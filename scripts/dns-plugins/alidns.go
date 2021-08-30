package main

import (
    "flag"
    "fmt"
    alidns20150109    "github.com/alibabacloud-go/alidns-20150109/client"
    openapi    "github.com/alibabacloud-go/darabonba-openapi/client"
    "github.com/alibabacloud-go/tea/tea"
)

/**
 * 使用AK&SK初始化账号Client
 * @param accessKeyId
 * @param accessKeySecret
 * @return Client
 * @throws Exception
 */
func CreateClient (accessKeyId *string, accessKeySecret *string, endpoint string) (_result *alidns20150109.Client, _err error) {
    config := &openapi.Config{
        // 您的AccessKey ID
        AccessKeyId: accessKeyId,
        // 您的AccessKey Secret
        AccessKeySecret: accessKeySecret,
    }
    // 访问的域名
    config.Endpoint = tea.String(endpoint)
    _result = &alidns20150109.Client{}
    _result, _err = alidns20150109.NewClient(config)
    return _result, _err
}

// 添加解析记录
func _addDomainRecord (client *alidns20150109.Client, rr string, value string, domainName string) (_result *alidns20150109.AddDomainRecordResponse, _err error) {
    addDomainRecordRequest := &alidns20150109.AddDomainRecordRequest{
        Type: tea.String("TXT"),
        RR: tea.String(rr),
        Value: tea.String(value),
        DomainName: tea.String(domainName),
    }

    _result, _err = client.AddDomainRecord(addDomainRecordRequest)

    return _result, _err
}

// 删除解析记录
func _deleteDomainRecord (client *alidns20150109.Client, recordId string) (_result *alidns20150109.DeleteDomainRecordResponse, _err error) {
    deleteDomainRecordRequest := &alidns20150109.DeleteDomainRecordRequest{
        RecordId: tea.String(recordId),
    }

    _result, _err = client.DeleteDomainRecord(deleteDomainRecordRequest)

    return _result, _err
}

// 错误处理
func tryError(_err error) {
    if _err != nil {
        fmt.Println("error:", _err)
        panic(_err)
      }
}

/**
 * [main description]
 * @param action
 * @param endpoint 服务地址
 * @param accessKeyId AccessKey ID
 * @param accessKeySecret AccessKey Secret
 * @param domainName 域名名称
 * @param rr 主机记录
 * @param value 记录值
 * @param record 解析记录的ID
 * 
 * @return {[string]} [ok:recordId | error: errorMsg]
 */
func main() {
    var action, endpoint, accessKeyId, accessKeySecret, domainName, rr, value, recordId string

    flag.StringVar(&action, "action", "", "create or delete")
    flag.StringVar(&endpoint, "endpoint", "", "endpoint")
    flag.StringVar(&accessKeyId, "accessKeyId", "", "accessKeyId")
    flag.StringVar(&accessKeySecret, "accessKeySecret", "", "accessKeySecret")
    flag.StringVar(&domainName, "domainName", "", "domainName")
    flag.StringVar(&rr, "rr", "", "RR")
    flag.StringVar(&value, "value", "", "record value")
    flag.StringVar(&recordId, "recordId", "", "delete recordId")
    flag.Parse()

    client, _err := CreateClient(tea.String(accessKeyId), tea.String(accessKeySecret), endpoint)
    tryError(_err)

    switch action {
    case "create":
        response, _err := _addDomainRecord(client, rr, value, domainName)
        recordId = tea.StringValue(response.Body.RecordId)
        tryError(_err)
    default:
        _, _err := _deleteDomainRecord(client, recordId)
        tryError(_err)
    }

    fmt.Println("ok:", recordId)
}