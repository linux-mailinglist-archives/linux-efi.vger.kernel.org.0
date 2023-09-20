Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC79F7A8EA3
	for <lists+linux-efi@lfdr.de>; Wed, 20 Sep 2023 23:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjITVms (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 20 Sep 2023 17:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjITVmr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 20 Sep 2023 17:42:47 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 186399E;
        Wed, 20 Sep 2023 14:42:41 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38KKJfxw031827;
        Wed, 20 Sep 2023 21:41:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=v8+XTqAQh19lcUUk/ATZcfEHZmtiqfd8yXIhQ6Hq0M4=;
 b=Y4sYM8bo4zoVcE06WJPgcbq/B5YhJi2w+OhO5dHlhOp60wG+7L1xJeiVNIBL4gx9S+uk
 ah5Dg62M5jaAgko7oYJ0F/NtC+3qzfZd5DYiL+UltAzrvKpXwP+TbmxmlRgcH77+/cbZ
 mdF52AAB0QyFimlslcUD7cglst9WuV2FOp+dyWNJRHJNtoQg/ErTkOF8VNWqZThJDna1
 NNsnVN+vJKUXQU35w7xTWiVquSs331faTEeDW4Yllb+rQmZj2fc087j0uKlTsp/MxZXC
 yp95AtJhvlv6zVX5jOYcnfBzICpi+2IWzpPFsPbliPvkv5eJs2ifgjGQVHif8UymKSgz og== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3t54wurdjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 21:41:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 38KLcXTi015956;
        Wed, 20 Sep 2023 21:41:03 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3t52t7e6ck-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Sep 2023 21:41:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6qg62nMmkwspyQdCOF62k1o1u5U4pcp5YOjpvVxvzfXc5wSEjjNYFnVkLCHAqs9weqX6uUO7Hkg4rSRmLBN1qlUDcON6peN0gB7OR8YAglePH23s4rX4ou1RjiFhyymhCJrYbWmxl2z5eOwkNP+mFHIEG98W0VnAYmW/clcYZdRIn6RdY+4oLpHf3uvw3V3RbTOJJb1NNo6ot42iJFgJSpSomVAkOYmbAo+yNftQTt8wNlyM8ZdjNRumhxmZ69Cqq7MUF86D7xzIjpaybCpZRJqksXkwJI4+LDLEGOX7jA0vcWTyKKjvO72+Lwgx5YrmnQ0UEdksae57YywblsD7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v8+XTqAQh19lcUUk/ATZcfEHZmtiqfd8yXIhQ6Hq0M4=;
 b=SqwMX6n07TKsDf82gG06PDv3/EKDEYt0djQPSHtjHB2O6i4za7TOU1WhuoM0SZrcbgX6IPOgQLhzolvJx6qV8d8gJ+rj1+WsUEJlSBCvjqcWBLGDBu6uxgNMBP9fRrKURl+1T/etgBH66AqbPMvHROvY0DErbaUBs6D+6hqwxd4U5E0D6yNq3ja+24ihdEKvwEWWKPOYDKfR6BpRkL9srlAfhFdSo5iMHkjv6W+J7W6BBrmtGciCbqtnsYIhQ3uldMgjLg9PPv4uSa7lZLIcTCWobHw3oie4sDuTPfYSnXhmlO1Ya3E7gGYSKThAebBYOZ2YzgirKkh4XEvBvjtaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8+XTqAQh19lcUUk/ATZcfEHZmtiqfd8yXIhQ6Hq0M4=;
 b=XBOR8LTeOIisDKRAu7Y7Sw01SmXHMtg5/G5yAZCmD8mr2GYrn2oZwFEnC7RT4/yrhy/40K5VEETyra1i7muegoxt7Y//i+n3Aj2MRYsLC8gOZEg3L7vEtkh+h0IeoZWPIUonvm5CiMSD/0dg2xXKJURomwSTRtMtla0U7ujqqD4=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by MW6PR10MB7614.namprd10.prod.outlook.com (2603:10b6:303:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 21:41:00 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::9a11:e917:b31d:3911]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::9a11:e917:b31d:3911%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 21:41:00 +0000
Message-ID: <25849838-c18b-f345-a36b-63fbed427886@oracle.com>
Date:   Wed, 20 Sep 2023 14:40:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-integrity@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org,
        iommu@lists.linux-foundation.org, kexec@lists.infradead.org,
        linux-efi@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, mingo@redhat.com, bp@alien8.de,
        hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-8-ross.philipson@oracle.com> <87ednlbf50.ffs@tglx>
From:   ross.philipson@oracle.com
In-Reply-To: <87ednlbf50.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::16) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|MW6PR10MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: f91c7851-5fdb-4ea4-94c8-08dbba22482a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRep6XvkeuE1XyKoYBvdWZRPaVWewU7GFIkDZxqAhCRbVK/jHYUbsATlSv2jlHwFylet8Y2w16RDqHsFOwVtEXRwExF4GB+fDEz7vJFqWgpXNNIhTR9xsueqN66AxNDxxsUcT3r68QJ3FdC+/0Xr1HXg49naYne+8UM1mTbLTGTE9nHSpWdhKkC5K9M6xgcNimM5v0dMck/QZwJeANoGVaUL9RGIYGcJO7EWIDtkCFEwFI6OlvHW6OlXMlnO/eq7re15EPWk5uxI7FOAkVRxEdCUPyhPCqFh2AA2vQMWnkUwFckMSH32e8vfj0nqMSPnsoxSf0PZGl5T1ThkF9BzTwvDxtmu98kcgKRPczEVy5ySQUEx6c5jeCO6pulBJu94OT7EF9/WmEJ1BU23MawQP2GZZZrRNYKNEoXfvCaF1jsdPONTUf0bQytse4w1GciYcVUHDokz9liRLD/6fTaNMtUlKUNEBxV4cW625EOeMF6NJMLDyd6dBRKgPlycFcvFNeonD7Up7l+M7VB6KKBdAavdQ8cJ9Dnmw3J1mFb+yE1rmSB8XQP6u51shBv5MNoIu5lwG4pPkMEkRtJxGTNcUneihXa6G5/K6qYPBzw6S4v2wnz0bR6s7Zm/x4agLETb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(366004)(396003)(346002)(1800799009)(186009)(451199024)(2906002)(5660300002)(6512007)(83380400001)(9686003)(2616005)(7416002)(316002)(26005)(41300700001)(8936002)(66476007)(66556008)(8676002)(4326008)(66946007)(6486002)(6666004)(53546011)(478600001)(6506007)(31696002)(38100700002)(36756003)(86362001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjRUYkpmeGE1MGFod3hWNHlYT2hsbGZNRGtydGpQK0duT3JyUXhMVDM3RG1z?=
 =?utf-8?B?NVNrUWFWem1IRWoyVGpWbTNGMi9xNEtaT0orWFMwa0lvK1dMM2k1RTNxRFhS?=
 =?utf-8?B?RTZJeTRrT0d0Mmx3TFdCSGJqWS9MNEZCMStqUlN2RlhWWjQ0bDV0UmM1YkU2?=
 =?utf-8?B?eVZQcm0velVQQW0yZDBQQ252L2hRdkVxbGdSNWdFVUlhVHJnY2NiZGhWTXRh?=
 =?utf-8?B?R1ByOWM4dm96UDY5bkZqQTlqN0tDZDRYSkJUTHR5ME9LdFAwckNVbGJwMnFR?=
 =?utf-8?B?ZnBWREtFMTcyOTVnWjFta0JkNXltQUVwczdhODNYOEx1S1ZLV0lnemNzNEJP?=
 =?utf-8?B?a3k5dFZBbVR4MVBvNGI3TDVHdk1RSTgvdnRPQWE1ekdQN2k5UnpVQmVKRERE?=
 =?utf-8?B?eDJiUXJwdmNvMi9ub0tKNEpWWnBKQ0hOUlY0MEdxQjV1ZEdtcDRVUk5pTEJh?=
 =?utf-8?B?dHNPVzArdUd4RVdBY0pMc21GYWFjaDVHOTJIbkpmMVNlN1Rha1pxZnJVU2pK?=
 =?utf-8?B?akE0Z2RDZ1BMd1F2V01wbjNlUTQxRkFrQUhoamYvY3lodWVvU05kTFV4NnNw?=
 =?utf-8?B?Z1I1OStDdzhYRHdtS0ZDREptdHBxZDUyNGtJNkVRZXlSa0lQakphbnJmMHlj?=
 =?utf-8?B?MWFTblhoY1JmcEdJOTlQSlVESWFxTjV2dERuaDA0U2o1dy84Ylg0elZBcTVa?=
 =?utf-8?B?Qkc0VWkvRkF0R3JLcGRORUUvdTdNSEJMSlJHNEpVMVYzT25sSm9RK1lyNXF1?=
 =?utf-8?B?OUozTTRSV3AvRVdoVG1DM2tiTnBkYjhvWGF0dFowYjZVYk5qSnNsaG1zVFFy?=
 =?utf-8?B?cFJrS1JCeTRNeU4yVGVEaEpPNkNmYmtUa3p0OG1SdU96d3huLzRNVkVPM1Vw?=
 =?utf-8?B?VTgwYm9oRGllTy9MbzBoZzl6YWhqQ2tWMW1zVHNnemsxdkg2M0Y5c1ppY2VS?=
 =?utf-8?B?aFdjTmh0a1hUS3FkRSs4ak4xbElxcitaV0N1NHEvb3FCdkZlSXdtZ01UV3gx?=
 =?utf-8?B?VExDdnZZYks5MXFtSXdVSmZaTGh6aitZWkE4WmYxRFQyOU9taGdvaUhITmlI?=
 =?utf-8?B?c2FHSTFkVUQ3UE95aGthWXd3NzVwTmJTNllzcXJJcjJHQUo4L01GZjNYL1ZN?=
 =?utf-8?B?cXlaNUFRUjZwcnIyTEQ1VkMwb1lXTFlEVHlSeGlzdFdiODlhN0N0bExFNzNl?=
 =?utf-8?B?ODRWQWVQL051Sy9OaFRmMzZTbVBibXVxcC9RcTROMWFtUjlTeXlOcGloTkZq?=
 =?utf-8?B?NUNrVWtpNXZtczJjQW1QNUhnVjJNdWU0VDdyai9QZDVVb3hJNGNVZllsdlA2?=
 =?utf-8?B?QURyNmxMV1p4YVBDMCt2M3ZZSGc4dmpkU2NuMFRWbEJlN205eGU5aUk1YU1m?=
 =?utf-8?B?NWQyU1kwTFdZTGVqSWxoWTFldjd0dkV1Q3FPa3B2U21SS3luMG1qQ0VQbGt1?=
 =?utf-8?B?ckkrV3NyeEtXZWcydkVqWTBGM3UwSUNIU3g3Z0NidkRtM2NDdWtMWGNoZDZS?=
 =?utf-8?B?ZjA3Z1dlcVh5L1NFY25TM2U0WnhLNkxvM2RITmJlTEpqQ0ZjdjgrVGdMTm1Q?=
 =?utf-8?B?TzlEQjAyM21QQ1pPNFQ1SSt4U0Q4QmhWTWxvYkx0Z3pTb1gycVN6YWxPSStV?=
 =?utf-8?B?aWdGdXRjWVl1dHE2Zk1Ma3daSmZBcEtoS3AwN0xLbHk5ZWNPTjFNWXBBYmhu?=
 =?utf-8?B?amNMam9jUkJGZWx2TVhOUXBabTJXelJRdjNVMTdReXl4Z2hYeGZ4RkxaS1VG?=
 =?utf-8?B?LzllUzh5ZHB0OEJSVG5DTWZnZFlkUDdVdUdhS3lqaEpsZTFwSE5DWjVRMjg5?=
 =?utf-8?B?cUdFZmJJbU1RNzRFM2l3d1FXN1IvK0pUOVpubUdkZ0Z6QnY3OHFpSlVXQkRZ?=
 =?utf-8?B?dnM4bC9YbXh3RFdwYzBoZ0piWkFIZU8zSmFQNXZEUU9nZE15VTV5NDZ1RXhO?=
 =?utf-8?B?cllwMUpQdHlvVnRhbVF0YkZqMHV2bXFXUDhBYkhlRWw0UWMrT1FXS1lxU3dj?=
 =?utf-8?B?VE5ENGxYYmx3L1dWN2k4ZFFqcEJjaXZjakVkVDY0d2R2eGM3MWl6dzk0WE1S?=
 =?utf-8?B?L1RCbXVRalBLTlFuUnJ1VGM2WjBnRWtiRVVYbGcvOGlkUTNUdUYxZWtBQU5Q?=
 =?utf-8?B?NkRyZStCbjY0NS8yc0Exc1hPZkoxQWxUZ0M2SFpOKzNlbkNuTHJzeTliMFpl?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?dW1yZnlSbVRJOEI1bis3SmRpYlh5b0M0ZmlTS2NKVWJYam96anpjNGQrK0U4?=
 =?utf-8?B?NjRkOXZmR21idU16RHlXbk1uR1lCTllZWjg3ODVWekhZaWh1bnA3NmUxeG1Y?=
 =?utf-8?B?cTZuTVJYVXFuRUpXeGZMYmFKL0duc3J6b2xVelNCRmFqd1NlUlRFUXJiK2hv?=
 =?utf-8?B?Ly93YmwwVmRXQzBxa3RmeEZ0OFNjRUJTY0ZuNmo4ZkRWdVJhT3RvNTJwL3hj?=
 =?utf-8?B?WDJpbkZkcEtudEpMRW4vTlpQeW5FcXZ4YVZtc1BUSFo5N0dLMkNpMFlVMGtz?=
 =?utf-8?B?emtVYmFnNTVXRWNmeWx6dTRFL0ZiaGlvd1BSV3hEcFJJeFBZdHpubUpvZHJm?=
 =?utf-8?B?eHpGSXAvTGxRbndEZ1lnVGp5R01YOUtZd0QrRU1RRTUvUEd6UHhtNGxzR3Iy?=
 =?utf-8?B?YUJMcWJXb21VSnhkVk40a2h6YjVGM1RzNXM1Sys3ejBCMWNRbS9kQjVSa1E3?=
 =?utf-8?B?dXNNdUNuQUxjbnE4ZVJjVWhEcERnNjZlZnVidGZ2WHVka2xkOXVLa3g4clNJ?=
 =?utf-8?B?K0NIY21hNThYdmtUaFZ6N0lSMkhpS3NZTXRuMTJQWEhjNUdBSHhRQml0bXhh?=
 =?utf-8?B?TjZVdk9DY1laLzJIVm5vVkk2dTdPdVRIbng1R2dPMmthVlRLN2V4Vnh4VDNN?=
 =?utf-8?B?NTNQMjhVZTFPNmlIYmxrNFpWZGpDQzJuK0FrZEpiTXZnc1VCSGNnRGdTUEUw?=
 =?utf-8?B?R0picVlIU1ArWHVrbGNyUVBrWXZiT0h6UCtTSlBnVGEvaGYvZmZObm5iK2tC?=
 =?utf-8?B?dlZ1dWgxNVpha2p3Q1pMVUtnM2lFUHlVT2FnZzBlNlJwaE5BbmxNNU1ETjZP?=
 =?utf-8?B?OUswWXRtSzQvMk16VWR1alRuTU5oY3RBYU5BNFhTRG42ZVVPa0NkK2VYSmFt?=
 =?utf-8?B?YmlKU3BhRTRTRzNBY05JVXgwUkg0VXZQNEtJbDlQQzhDVXRIdHhrcFhxcUZD?=
 =?utf-8?B?NFI0WkpuTCs1NkhPTCt5ay9DYlZSMTBFWFYrb3NvQk5yZ2lidnFCZ3lHYlNk?=
 =?utf-8?B?czJoUkpGdmRiUWU0YVpNUThJaEt2czgzRHhpQVd6TG11VGxjM0lOVHNNVjkv?=
 =?utf-8?B?SWhGcXZJVG5HMVRoc3FMeUkraUIyTmM1UWRDeXN1Mm9jMHFWTU85YW95UHNr?=
 =?utf-8?B?RG93SlZrRjBMY1pDSGp5TTFZdjZrK3M2WmRkd3VTY0FySFhzZzdRb1AyVXJi?=
 =?utf-8?B?eHNrc2lQTC9UcUtBYi9BM05tMk5kVXF0MWlUdGUvQlhwL2dKVEJ2NE5uNW5S?=
 =?utf-8?B?R1V3dXcxOXlkb3U0YUxYTllnWmQraU12R0RHNTZKYkJ3UzRNbzRTUGx3Smla?=
 =?utf-8?B?YTN3YTlUQU9MUmg1SjJOd0s4SlZwWi82TW5jSFlzODRFWGpVZGNhYmpCeWtV?=
 =?utf-8?B?eHJXNlZHdVg3Y3lxbDg0VzZNTVVUb2xnVHZKQzNubTlzcVZFb2xuRFFweDZH?=
 =?utf-8?B?VStLS0tTMU5SUTFLL0ZITXl4WFRXNkZseElWUXJFZnNzTjl3MWJlcC9lSDVH?=
 =?utf-8?B?dzBDL1ljRERvbm5QK1RZQmxQSFNlbTlXUHFxVW5nVWFZaDZoNlhZQ2dETmU2?=
 =?utf-8?B?TzJZQVg5VFUxaXhISzJ4T0FyUFdjU0g2akFRNXNCdmR2M1U1TzlleTM1dlVa?=
 =?utf-8?B?NzJXTzA4TEpLYnFabzNrbGdaQW8rZk5yMnhnWTdCcXRyOEJZaWFXdTJpdEkv?=
 =?utf-8?B?ZlNkRGwvdTBWd3hTRzB6QWtES0NZVGM0Ymp3L1lwYjhwcysva3JMbTdHdGMx?=
 =?utf-8?Q?rDbFR6N50DQY4ObiOU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f91c7851-5fdb-4ea4-94c8-08dbba22482a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 21:41:00.7060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zaYuJJcwYnSJ+1vuok33GCuERjvB5eD0WMikfyp68FqOl/+qL1+4Sfr6hR12jRRxezR7dHS8rdvdyNu+8sDVwDEwrTlVLlyaTE8/gg1uE/c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-20_11,2023-09-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309200182
X-Proofpoint-GUID: 2EiBUn9m8gFlkIuCrSMoZv3OuEkaoiMD
X-Proofpoint-ORIG-GUID: 2EiBUn9m8gFlkIuCrSMoZv3OuEkaoiMD
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/12/23 11:04 AM, Thomas Gleixner wrote:
> 
> On Thu, May 04 2023 at 14:50, Ross Philipson wrote:
>> +
>> +/* CPUID: leaf 1, ECX, SMX feature bit */
>> +#define X86_FEATURE_BIT_SMX	(1 << 6)
>> +
>> +/* Can't include apiddef.h in asm */
> 
> Why not? All it needs is a #ifndef __ASSEMBLY__ guard around the C parts.
> 
>> +#define XAPIC_ENABLE	(1 << 11)
>> +#define X2APIC_ENABLE	(1 << 10)
>> +
>> +/* Can't include traps.h in asm */
> 
> NMI_VECTOR is defined in irq_vectors.h which just has a include
> <linux/threads.h> for no real good reason.
> 
>> +#define X86_TRAP_NMI	2
> 
> <SNIP>
> 
>> +/*
>> + * See the comment in head_64.S for detailed informatoin on what this macro
>> + * is used for.
>> + */
>> +#define rva(X) ((X) - sl_stub_entry)
> 
> I'm having a hard time to find that comment in head_64.S. At least it's
> not in this patch.
> 
>> +.Lsl_ap_cs:
>> +	/* Load the relocated AP IDT */
> [ 11 more citation lines. Click/Enter to show. ]
>> +	lidt	(sl_ap_idt_desc - sl_txt_ap_wake_begin)(%ecx)
>> +
>> +	/* Fixup MTRRs and misc enable MSR on APs too */
>> +	call	sl_txt_load_regs
>> +
>> +	/* Enable SMI with GETSEC[SMCTRL] */
>> +	GETSEC $(SMX_X86_GETSEC_SMCTRL)
>> +
>> +	/* IRET-to-self can be used to enable NMIs which SENTER disabled */
>> +	leal	rva(.Lnmi_enabled_ap)(%ebx), %eax
>> +	pushfl
>> +	pushl	$(__SL32_CS)
>> +	pushl	%eax
>> +	iret
> 
> So from here on any NMI which hits the AP before it can reach the wait
> loop will corrupt EDX...
> 
>> +/* This is the beginning of the relocated AP wake code block */
>> +	.global sl_txt_ap_wake_begin
> [ 10 more citation lines. Click/Enter to show. ]
>> +sl_txt_ap_wake_begin:
>> +
>> +	/*
>> +	 * Wait for NMI IPI in the relocated AP wake block which was provided
>> +	 * and protected in the memory map by the prelaunch code. Leave all
>> +	 * other interrupts masked since we do not expect anything but an NMI.
>> +	 */
>> +	xorl	%edx, %edx
>> +
>> +1:
>> +	hlt
>> +	testl	%edx, %edx
>> +	jz	1b
> 
> This really makes me nervous. A stray NMI and the AP starts going.
> 
> Can't this NMI just bring the AP out of HLT w/o changing any state and
> the AP evaluates a memory location which indicates whether it should
> start up or not.

I have switched the existing code to use MONITOR/MWAIT and got rid of 
the use of the NMIs here. I am currently using a monitor variable on the 
stack of each AP but I think I may refactor that. The next step is to 
rebase this work on top of your hotplug patchset. Is the code in your 
devel repo on the hotplug branch still the latest bits?

I had a question - more a request for your thoughts on this. I am 
currently assuming a cache line size and alignment of 64b for the 
monitor variable location. Do you think this is sufficient for x86 
platforms or do I need to dynamically find a way to read the CPUID 
information for MONITOR and get my size/alignment values from there?

Thanks
Ross Philipson

> 
>> +	/*
>> +	 * This is the long absolute jump to the 32b Secure Launch protected
>> +	 * mode stub code in the rmpiggy. The jump address will be fixed in
> 
> Providing an actual name for the stub might spare to rummage through
> code to figure out where this is supposed to jump to.
> 
>> +	 * the SMP boot code when the first AP is brought up. This whole area
>> +	 * is provided and protected in the memory map by the prelaunch code.
> [ 2 more citation lines. Click/Enter to show. ]
>> +	 */
>> +	.byte	0xea
>> +sl_ap_jmp_offset:
>> +	.long	0x00000000
>> +	.word	__SL32_CS
> 
> Thanks,
> 
> 	tglx

