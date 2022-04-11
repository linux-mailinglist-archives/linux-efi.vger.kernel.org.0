Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27994FC5E8
	for <lists+linux-efi@lfdr.de>; Mon, 11 Apr 2022 22:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbiDKUhr (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 11 Apr 2022 16:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238016AbiDKUho (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 11 Apr 2022 16:37:44 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EE31836D;
        Mon, 11 Apr 2022 13:35:28 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BKFHGY022836;
        Mon, 11 Apr 2022 20:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=Xy/Gzz7HG1Z3rj1Vj0EvQyzvf6rPPG+cWQERIDVoGZ0=;
 b=LeHkVzSrkghzcjatxELTi6Z1XoaZys4WISvuAETU6qAoQvNl7o+TvKFSeK/lt4SBMkrI
 4nINirZpZ9jEaksdyyH+/ujnaDq9OjYdkXePiWhldXN8OV+ZGcnl/Fc9+QEW9wry+2ND
 Zf0+z7IyXkIGnBX+6NcFtTJZ+ZpdkTp7SBhOQhzD4QUfXRNpZMI8+9EnY2zxOJwcG9Uy
 TxKjOdnZnhP4z2be4et0KzrSr32SdfcYzAfTcVNJnfGuDIg44cECvh/owfBA8pV3wNZS
 FcV2ExeghXGqg/BCnS/JyDAh//HPMKlrfaTgNEoZf9tuEcaLmz4rfxSIfY8ZeKessueS 0w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd4ueg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 20:34:58 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BKQLgh016308;
        Mon, 11 Apr 2022 20:34:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9gne67-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 20:34:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tc17ARtHZ2QgWM7JTwlYjKvKqnwzmngJY3OogYW3NsJximqROz5pytmiaZKAP4V7Wu137YSc6eaXSVKUOkKrVCwOkb51n+IM8C+2IhOBp/lJ4uLTA2NF4+eRHJFKW0c0cITFBb/f2uCuPOG3GBylJQBtk9bKwqG5aauFGEtrxfqXQ6lvDdNQu1CmF2N6Xml/BFWxy+ZkQXaQmrGOUHbpCJvGY4PJmMtzA00fdHvUBoeVzgbfO/mxkGFT2d2QcwaPF3+PefFdXyCP28mbP3x4hoXwNzNg4Lm2FHLioHvpo3tg9wyaNlOVfYzUGK1bnb5A3RTgfAznlOv5tynMtjNbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xy/Gzz7HG1Z3rj1Vj0EvQyzvf6rPPG+cWQERIDVoGZ0=;
 b=T9RzkUA71EUOXdOyJl4TIq4SaUoSY73NrY/AIDpVNgBGSWRPplJGGBPnmZy/8y2zEqmQ+W7jTEuhIljZbNWntafohRtCKAql3Xy3Uy0L/Fn/ZOO73bKiXnOtwRSZVXujYgB8Zox7Y4pwMWtvBsZPilMoZbK/aeYuiRqfK0MuSaYVASeOWXkhlJLgrN7IvERRgIbP6zL8rDpp/ry0fLR+IV5IvIr3VE0N9EQhmlCNMGzydGOI6e6uzbfPRkK5B+5ficYh/gp5hscjABITkG01sYzPCyRXVhEhvaWMeYHpB+MeU0En523ufSQRtcgEvAoZCsQNzOiNVBWD4UlgjTebZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xy/Gzz7HG1Z3rj1Vj0EvQyzvf6rPPG+cWQERIDVoGZ0=;
 b=EOqYZgSF3k6A5T8wyM4pXK3kgFLEWQYlx1zLdeBeZlUrgW+XuAq7mBwyk/96wdzPIZPtPnfe/STw8b19nEIcShMGv/UNM/QAEMiDbd+B2I41A0whXtuOU/4rWYnf82dLm5WaQJvF9Xf/pEWXMfurtqtrWBsbI0FXQCGhhkxqxbw=
Received: from CH2PR10MB4150.namprd10.prod.outlook.com (2603:10b6:610:ac::13)
 by DM5PR10MB1772.namprd10.prod.outlook.com (2603:10b6:4:11::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 20:34:56 +0000
Received: from CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55]) by CH2PR10MB4150.namprd10.prod.outlook.com
 ([fe80::7ded:5b3:a28f:2e55%7]) with mapi id 15.20.5144.030; Mon, 11 Apr 2022
 20:34:55 +0000
From:   Eric Snowberg <eric.snowberg@oracle.com>
To:     =?utf-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>
CC:     David Howells <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v10 8/8] integrity: Only use machine keyring when
 uefi_check_trust_mok_keys is true
Thread-Topic: [PATCH v10 8/8] integrity: Only use machine keyring when
 uefi_check_trust_mok_keys is true
Thread-Index: AQHYEmDFShDCf3sk8k+AOahiwptnWqzrA64AgABdC4CAAAyeAIAANRyA
Date:   Mon, 11 Apr 2022 20:34:55 +0000
Message-ID: <54B1CDD9-F690-4F1F-9A9A-9412AAB21A72@oracle.com>
References: <20220126025834.255493-1-eric.snowberg@oracle.com>
 <20220126025834.255493-9-eric.snowberg@oracle.com>
 <20220411110640.GC163591@kunlun.suse.cz>
 <C970A5DB-0238-4B5A-9935-588DF9B1DDEF@oracle.com>
 <20220411172450.GD163591@kunlun.suse.cz>
In-Reply-To: <20220411172450.GD163591@kunlun.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3608.120.23.2.7)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9119993a-f19e-4069-d07e-08da1bfabd67
x-ms-traffictypediagnostic: DM5PR10MB1772:EE_
x-microsoft-antispam-prvs: <DM5PR10MB17723D2C6CB08676E00BF46487EA9@DM5PR10MB1772.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s+2NDp1sOqcwY+TKaazMW/LatnHIuC3IvKDUX1QJg7RBXq4ET6SlNDFMOarSHXyLOkFxlybYmu9jNqbLn8w+dAmDwRcxnu8T40hiaiRd3UL0EZ5jUY2Y3y2LRSIhecGXLEseGeiRVI/2smS+II2EF/8N7dxv4evtlne2SK87IkzU1FMtpPX7kbu1WyoHWJ4rD4D+cIqRxg2alrpKZnCKjoMQAWxTzEGputce5s576GgG5ZXRHKo4qFnl+5uI8rbrG6iZ915ssyF5ZYGzeb7+fPtfed/smLCS/EozmjnXI6vg9wvgB5iDIeJoh6SxfAjtXG3FI05XyNFo+SiXh6bo1nEGNN1vT8a7XR+75UCfQ4qj6lxXDd5icTEmWCuF8QJXSWTzWlkPCvy7HEIM1xdcfcaZY/uS+IRrL0HLKGDM8oOM60de0xCXfkceWF3SIFdr1JuSDY0dQV0FjVs5IF+CwKYEI4mCoac9TJLqfdyeafABIXv48ZHo0Fc9OdpzFfnW1fbhrmaOP4FD3IHvQI8t6vrasfxLpos4tS5wSmowv90btvJYKYTUwpX2tOYz+jsMZnM1N+sObRE4NwNxnoDTo74NGCOO3LKO4XYdl/G18qiU85wUPMWkIaY2PTnw9FkUnobhBPNU+lbuZUzJ4joyT25BtFFnYZY4TomOLsr8Cj9ryCCKSnAuiWk+mIsAvNk46Elr3Lre+/Zzh61iVs27MvyK6TwO8/jNOWi75m5Ln5o=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4150.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(64756008)(8676002)(33656002)(66556008)(66446008)(76116006)(66476007)(66946007)(5660300002)(4326008)(8936002)(508600001)(107886003)(122000001)(2906002)(2616005)(53546011)(44832011)(6512007)(6506007)(6486002)(86362001)(316002)(54906003)(6916009)(38100700002)(7416002)(38070700005)(36756003)(26005)(71200400001)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VitxRUxMcDBiRENLaWM0ejFRZEQxeVZrM2pOTEVSRTBzQnVIMjZRMWF1b1ZZ?=
 =?utf-8?B?eHlnb0o3U3R5RGx0Wk91MG5GZUJxa0tnTlJNTWZHSFRZOE9pMldDVnlmOFNJ?=
 =?utf-8?B?NWpaSndDWXhoSGI2L3VITFhpQ0M5RjVyV2xEWUtzKzBSKzhTSWtKNmJBUGt1?=
 =?utf-8?B?V2VkTzh2SkdVemxKR2ZMWXBlSlhkMW96eDNNbHFhMllqVVpyRDFscC8xOW5H?=
 =?utf-8?B?dFFJa0JLSm5VODNYRHNMZi9oc3ZRbEsyRldvQjJlemp6dWtSRzBBN1BMTHRJ?=
 =?utf-8?B?NnZVU20reE5PK0NES1liblVFcmdiNEQ3clIxSkxmaHhEVFdobnphWUplUllQ?=
 =?utf-8?B?aWVLcFVZVGZNcFBCNWp4anNhVmNJRXZ5UGtmUGM1cElsbHlXZjVaWlkwREZC?=
 =?utf-8?B?WDcvN1dBUGJQZ0VwWk8veEw2eHlDZXNSKytvaHJXRmdGd1lSRXZYbTBDK0k2?=
 =?utf-8?B?MG1MMEJKS0Q3WXpGTE9mbDdES25Iak9qeWxPZkpkaGVDWVBjWXdMWWN2VDQr?=
 =?utf-8?B?ZW9DYThDWklvV3AxbVVoZ3JSYTFxbXk5M1g0aWN4REtGUEUrSGVOV0lFV01F?=
 =?utf-8?B?cVF2SHVMTDZvdmZ1R1RrWTNic0ZXYUMzTHFkYWdxZGFkTnlOR0NrSnllcE9M?=
 =?utf-8?B?VE9oZTg2TFpkK3UzNVlISlJDa3lHQ2RicURWYXo5RFNRYzUzd3AyUnAwRHRZ?=
 =?utf-8?B?U2FycE52L2FYb0RsMm9wekVoVnBvaXBZMmFkc05uYlhqQTNXMjNrOTBtbjJv?=
 =?utf-8?B?QWJrcm9sRWdLMEZPM1Bka1pWMDdxbGNZeUNpUUZuSEZoV1VVM3VEMjFsaHB4?=
 =?utf-8?B?d3MwMUI1UDBxV0tLdkhqZHhKUFlZY1phNlcrYUZpSUVadDFmNG9oVWZIVzZX?=
 =?utf-8?B?bDBFaVRjOEdnUXNWR1VVeGtxa0xHYW1YbGZONUxaLytEQkZFMTNNNmRkMlpx?=
 =?utf-8?B?ME94aUcraXlLZ0dJcGlibDVtb0UwM3o2cWEvc2ZkRTBtM0xWL0lWMlhiMk9i?=
 =?utf-8?B?bnBMWUJkWkg1bHljbjM5U3E1aDhlUllYOGtiVDVxZkplVnpzTlpxMGtkOVQ4?=
 =?utf-8?B?NEZNL0ZkVlJmZ0pYQVgxRWNzV05VbGhKbVMwZnROaUR2OFFkSE5QejBJSWdF?=
 =?utf-8?B?YUtmTmxBclg3WWpDdlRtcU5EOWp6UXF1Y3BDaUwxQjJxM3JVNjUwNmVkSzVJ?=
 =?utf-8?B?c3daY0tnNEwzMUFZUm5xK296YjdhMzdrVmJmSHBnWW1wRGpSeGxNbXptVjZq?=
 =?utf-8?B?RVFCR1pLZ2Y2SGxDRUsxU1ZlQ1BSZU9WczYrT2U2YytNRTkwK1Q5T2RhMGxy?=
 =?utf-8?B?aStNUTNrN3B5d2V2eERRM256R3hWWGp3WEd2cGU5R3ZDSnNrQkJOUFdEVDIz?=
 =?utf-8?B?Z1JsVWtBQ2tOYUEyd3Y5V28wWkJzbFhraWxRV2ZLM2NkZ1AzYlNONXBGZEdZ?=
 =?utf-8?B?aEJ2TENJYk83MTB2RnN2UDM0SkxpaGRsVk1vWmFMWE1sWHVSRDhoTE1qb251?=
 =?utf-8?B?eTJ2Z2xSeDJTWUpkWVpxVmI5Z3krNkIwZGFtTDVPTExrejhlZnIrVlNqc0pl?=
 =?utf-8?B?Vm0wbzZCejdJRW9sQTNVcURjekcvV2V1QUJGSnZFYXk1N29acFpIdngyYlBp?=
 =?utf-8?B?SEhyZXl4LytVRTVxbWdDTDM5eElvR1Y0TGpHelBjRzI5T3ViKzJtOWw5Q0JR?=
 =?utf-8?B?cDUwcmRrdDdQQ2JkK0RWaVppck9sYVdvdU9aSEpSUWdHVHpRMDczeGg0WWhy?=
 =?utf-8?B?SHdvMmRLQTNGWGgvK2N4YzVrbnlXR3hkR3hvdyt4TU14b2Y3TmNIZVAzOVg5?=
 =?utf-8?B?R0duVUJEYVRJTmNyOEFZaE5YcE4wRVdRTVFmZXA5dGxXUEowZlJSYjY2bmdk?=
 =?utf-8?B?ejZBeW9jYjcyY2VDejlhQ21hN2l2MzNNejI4NVhqdjZYUU5XVXdRWENsRmts?=
 =?utf-8?B?OTFPN0VGbHB0N282WVJFSzNtY1lRNVpyMENTWWQ3c3NXMVlRVmNPZW0ya2F5?=
 =?utf-8?B?SXJadmQ2UjlHWjlQOG92SVVkMENXRkJQaWdhZUloa0VVU0I2MmxaRjZWeUU2?=
 =?utf-8?B?V05sL0V3VE5QbHB3WUc2dXQ4ckNQcm1vYjRFNjV1akZmekMzcyt3MzQ3VjE5?=
 =?utf-8?B?aUhad0RNNmxOaDIvWUlORzkyMlZMOWN5R1B3ejZ5MHc2OFJJaW8xOUtxRjdV?=
 =?utf-8?B?bWlBRVJnUWJQUk1LWGwvazZwOUtyYUNTbHE4ZWVrZ1YxVG9Weko4SHV2S3Z6?=
 =?utf-8?B?Rk1VNGw3QTBNYm5IZllTT090RWVLTVJnSDhMeEtnK3c1SmpDekIrNDJ1VWtz?=
 =?utf-8?B?OVdFdHJLSjZpa09IUXVPUS9TZlBsNlBzMi93VWFXTEJHdGNKK1h4MGtCdzVU?=
 =?utf-8?Q?h/p2O8EEeZ844AAw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DC6EA9B19FCE84409BC82AA3D1445643@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4150.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9119993a-f19e-4069-d07e-08da1bfabd67
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2022 20:34:55.9036
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M+7xjoh69J7W+CWfO+D3joNBjJH/1c9bxA5GqM/wd6abw0RCQ6SLVAjI1Q5s0EGLdurHjtLtwGpILhWYUzInD6NHWtU0e1Md8QE4XwkL+oY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1772
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_08:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110113
X-Proofpoint-ORIG-GUID: i2b0fx0qqEzYVnGYg1LuawYvlt45_DHh
X-Proofpoint-GUID: i2b0fx0qqEzYVnGYg1LuawYvlt45_DHh
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

DQoNCj4gT24gQXByIDExLCAyMDIyLCBhdCAxMToyNCBBTSwgTWljaGFsIFN1Y2jDoW5layA8bXN1
Y2hhbmVrQHN1c2UuZGU+IHdyb3RlOg0KPiANCj4gT24gTW9uLCBBcHIgMTEsIDIwMjIgYXQgMDQ6
Mzk6NDJQTSArMDAwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+IA0KPj4gDQo+Pj4gT24gQXBy
IDExLCAyMDIyLCBhdCA1OjA2IEFNLCBNaWNoYWwgU3VjaMOhbmVrIDxtc3VjaGFuZWtAc3VzZS5k
ZT4gd3JvdGU6DQo+Pj4gDQo+Pj4gSGVsbG8sDQo+Pj4gDQo+Pj4gT24gVHVlLCBKYW4gMjUsIDIw
MjIgYXQgMDk6NTg6MzRQTSAtMDUwMCwgRXJpYyBTbm93YmVyZyB3cm90ZToNCj4+Pj4gV2l0aCB0
aGUgaW50cm9kdWN0aW9uIG9mIHVlZmlfY2hlY2tfdHJ1c3RfbW9rX2tleXMsIGl0IHNpZ25pZmll
cyB0aGUgZW5kLQ0KPj4+IA0KPj4+IFdoYXQgdmFsdWUgZG9lcyBzdWNoIGZsYWcgaGF2ZT8NCj4+
PiANCj4+PiBUaGUgdXNlciBpcyBhcyBtdWNoIGluIGNvbnRyb2wgb2YgdGhlIGZsYWcgYXMgdGhl
IE1PSyBrZXlzLg0KPj4gDQo+PiBUaGUgZmxhZyBhbGxvd3MgdGhlIHN5c3RlbSBvd25lciAobm90
IHJvb3QpIHRoZSBhYmlsaXR5IHRvIGRldGVybWluZSANCj4+IGlmIHRoZXkgd2FudCB0byBsb2Fk
IE1PS0xpc3QgaW50byB0aGUgbWFjaGluZSBrZXlyaW5nLiAgS2V5cyBjb250YWluZWQgDQo+PiBp
biB0aGUgbWFjaGluZSBrZXlyaW5nIGFyZSB0aGVuIGxpbmtlZCB0byB0aGUgc2Vjb25kYXJ5LiAg
VGhlIGZsYWcgaXMgbm8gDQo+PiBkaWZmZXJlbnQgdGhhbiB0aGUgJ+KAlGlnbm9yZS1kYicgY3Vy
cmVudGx5IGF2YWlsYWJsZSBpbiBzaGltLCB3aGljaCB0aGVuIA0KPj4gZ2V0cyBwcm9wYWdhdGVk
IHRvIExpbnV4ICh1ZWZpX2NoZWNrX2lnbm9yZV9kYikuICBUaGVzZSBmbGFncyBjYW4gYmUgDQo+
PiBzZXQgYnkgdGhlIHN5c3RlbSBvd25lciwgd2hvIGNhbiBwcm92ZSBwaHlzaWNhbCBwcmVzZW5j
ZS4gIA0KPiANCj4gTWFuYWdpbmcgdGhlIE1PSyBrZXlzIHJlcXVpcmVzIHBoeXNpY2FsIHByZXNl
bmNlIGVxdWFsbHkuDQo+IA0KPiBNb3Jlb3ZlciwgdGhlc2Uga2V5cyBhcmUgdHJ1c3RlZCBmb3Ig
cnVubmluZyBjb2RlIGF0IHJpbmcwLCBpbiBmYWN0IHRoZQ0KPiBydW5uaW5nIGtlcm5lbCBpcyBl
eHBlY3RlZCB0byBiZSBzaWduZWQgYnkgb25lIG9mIHRoZW0sIGFuZCBjYW4gYmUNCj4gc2lnbmVk
IGJ5IGFueSBvZiB0aGVtLg0KPiANCj4gVGhlbiB3aGF0IGV4YWN0IHB1cnBvc2UgZG9lcyB0aGlz
IGV4dHJhIGZsYWcgc2VydmU/DQo+IA0KPiBJZiBzdWNoIGNvbXBpbGUtdGltZSBmbGFnIGV4aXN0
cyBpbiB0aGUga2VybmVsIGl0IGNhbm5vdCBiZSBvdmVycmlkZW4gYnkNCj4gdGhlIHJvb3Qgb25j
ZSB0aGUga2VybmVsIGlzIHNpZ25lZCwgZWl0aGVyLg0KPiANCj4+Pj4gdXNlciB3YW50cyB0byB0
cnVzdCB0aGUgbWFjaGluZSBrZXlyaW5nIGFzIHRydXN0ZWQga2V5cy4gIElmIHRoZXkgaGF2ZQ0K
Pj4+PiBjaG9zZW4gdG8gdHJ1c3QgdGhlIG1hY2hpbmUga2V5cmluZywgbG9hZCB0aGUgcXVhbGlm
eWluZyBrZXlzIGludG8gaXQNCj4+Pj4gZHVyaW5nIGJvb3QsIHRoZW4gbGluayBpdCB0byB0aGUg
c2Vjb25kYXJ5IGtleXJpbmcgLiAgSWYgdGhlIHVzZXIgaGFzIG5vdA0KPj4+PiBjaG9zZW4gdG8g
dHJ1c3QgdGhlIG1hY2hpbmUga2V5cmluZywgaXQgd2lsbCBiZSBlbXB0eSBhbmQgbm90IGxpbmtl
ZCB0bw0KPj4+PiB0aGUgc2Vjb25kYXJ5IGtleXJpbmcuDQo+Pj4gDQo+Pj4gV2h5IGlzIGltcG9y
dGluZyB0aGUga2V5cyBhbmQgdXNpbmcgdGhlbSBsaW5rZWQgdG9nZXRoZXI/DQo+Pj4gDQo+Pj4g
SWYgbGF0ZXIgd2UgZ2V0LCBzYXksIG1hY2hpbmUga2V5cmluZyBvbiBwb3dlcnBjIG1hbmFnZWQg
Ynkgc2VjdmFyY3RsDQo+Pj4gdGhlbiBpdCBoYXMgaXRzIHZhbHVlIHRvIGltcG9ydCB0aGUga2V5
cmluZyBhbmQgYmUgYWJsZSB0byBsaXN0IHRoZQ0KPj4+IGNvbnRlbnQgd2l0aCB0aGUgc2FtZSB0
b29scyBvbiBFRkkgYW5kIHBvd2VycGMuDQo+PiANCj4+IFRoZSBtYWNoaW5lIGtleXJpbmcgaXMg
bGlua2VkIHRvIHRoZSBzZWNvbmRhcnkga2V5cmluZywgZXhhY3RseSB0aGUgc2FtZSB3YXkgDQo+
PiB0aGUgYnVpbHRpbiBpcyBsaW5rZWQgdG8gaXQuICBMaW5raW5nIHRoaXMgd2F5IHNob3VsZCBl
bGltaW5hdGUgdGhlIG5lZWQgdG8gY2hhbmdlIA0KPj4gYW55IHVzZXIgc3BhY2UgdG9vbHMgdG8g
bGlzdCB0aGUgY29udGVudHMuIA0KPiANCj4gVGhhdCdzIGFuc3dlciB0byBhIGNvbXBsZXRlbHkg
ZGlmZmVyZW50IHF1ZXN0aW9uLCB0aG91Z2guDQo+IA0KPiBZb3UgZWl0aGVyIGltcG9ydCB0aGUg
a2V5cyBhbmQgdXNlIHRoZW0sIG9yIHlvdSBkb24ndCB1c2UgdGhlbSBhbmQgZG9uJ3QNCj4gaW1w
b3J0IHRoZW0uIFRoZSBvcHRpb24gdG8gaW1wb3J0IGFuZCBub3QgdXNlIGlzIG5vdCBhdmFpbGFi
bGUuDQoNCldoeSBpbXBvcnQgc29tZXRoaW5nIGludG8gYSBrZXlyaW5nIHRoYXQgY2FuIG5vdCBi
ZSB1c2VkPw0KDQpNT0tMaXN0IGtleXMgZ2V0IGltcG9ydGVkIGludG8gb25lIG9mIHR3byBrZXly
aW5ncywgZWl0aGVyIHRoZSBtYWNoaW5lIG9yIHRoZSANCnBsYXRmb3JtLiAgSWYgdWVmaV9jaGVj
a190cnVzdF9tb2tfa2V5cyByZXR1cm5zIGZhbHNlLCB0aGUgTU9LTGlzdCBrZXlzIGFyZSANCmxv
YWRlZCBpbnRvIHRoZSBwbGF0Zm9ybSBhbG9uZyB3aXRoIHRoZSBVRUZJIFNCIERCIGtleXMuICBJ
ZiB0cnVlLCB0aGV5IGFyZSBsb2FkZWQgDQppbnRvIHRoZSBtYWNoaW5lIGtleXJpbmcuDQoNCj4+
PiBJdCBhbHNvIG1ha2VzIHNlbnNlIHRvIGJlIGFibGUgdG8gY29uZmlndXJlIHRoZSBrZXJuZWwg
dG8gaW1wb3J0IHRoZQ0KPj4+IGtleXMgYW5kIG5vdCB1c2UgdGhlbS4gSSBkb24ndCBzZWUgYW55
IHZhbHVlIGluIGNvbmZpZ3VyaW5nIHRoYXQgaW4NCj4+PiBzaGltLCB0aG91Z2guIHNoaW0gaXMg
Ym90aCBzb3VyY2Ugb2YgdGhlIGtleSBtYXRlcmlhbCBhbmQgdGhlIGZsYWcgc28NCj4+PiB0aGUg
ZmxhZyBpcyByZWR1bmRhbnQsIGl0IGRvZXMgbm90IGV4aXN0IG9uIGV4aXN0aW5nIHNoaW0gdmVy
c2lvbnMNCj4+PiBpbnN0YWxsZWQgb24gdXNlciBzeXN0ZW1zLCBhbmQgaXQncyB1bmxpa2VseSB0
byBleGlzdCBvbiBvdGhlcg0KPj4+IHBsYWx0Zm9ybXMsIGVpdGhlci4NCj4+IA0KPj4gSeKAmW0g
c3VyZSBvdGhlciBzb2x1dGlvbnMgdG8gZW5hYmxlIGl0IHdpbGwgYmUgYWNjZXB0ZWQgYXMgd2Vs
bC4gIEkga25vdyBNaW1pIHdhcyB0ZXN0aW5nIA0KPj4gd2l0aG91dCBzaGltIHVzaW5nIGEgZGlm
ZmVyZW50IG1ldGhvZC4NCj4gDQo+IExpa2Ugbm90IHVzaW5nIHRoYXQgZXh0cmEgZmxhZyBhdCBh
bGw/DQoNClRoYXQgd291bGQgYmUgdXAgdG8gdGhlIG1haW50YWluZXJzLg0KDQpPdGhlcndpc2Us
IGlmIHlvdSBhcmUgdXNpbmcgc2hpbSwgeW91IGNhbiBidWlsZCBvbmUgd2l0aCB0aGUgZmxhZyBv
biBieSBkZWZhdWx0Lg0KDQo=
