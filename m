Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F4F703E85
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 22:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245312AbjEOUUh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 16:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245275AbjEOUUg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 16:20:36 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8840C13C04;
        Mon, 15 May 2023 13:19:58 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJsMF3009845;
        Mon, 15 May 2023 20:19:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=4wGI+ygV4ZrChr7WdeRxqwnXhpOfFlFMPPiaKAhupLk=;
 b=GN1pOr5nF6oBSzGffklsNmevaGUOWMVsCoXpJ1wJYD2+iEXitMbMuxAs//7JhQ/QAngP
 wIcSNIcarHIxIqgtR5ZiXAt1KR5yRiVAkYKqPD7VNnx6xNIGqhIZp38yysV403H5nS1Z
 Ub3nBWRSWxJOkFkQuuWVXwCAcoxlMjCjIbUCqWtTm+fkagbL4nBvm5+Krg4lfAnqCPMu
 xxN2EUTr28H7cqKUR9/o7e3iiVZeyzhxISHi4WD6QpjKFmHdzXBcoNy8KCCiydb8z3J0
 ygCQ66YOY0PeNNq+qFQYYQK7wDVAnxk0Bks1hIrGZxdytqXoltKkYAqGX+4qETXkDe+0 dg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj2eb0skc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 20:19:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FK2GVf022184;
        Mon, 15 May 2023 20:19:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qj109dv9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 20:19:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXCN3kjYhRTq/JCJKrZmBOT4dcLcs9iRarLXmQr4jdXGJ8q1cHFaMccjP19r5NLSvHJqc9Ekc5hMjp2VDbyU8bmO2rlX09bu/d5MVgHcYDNs8Cjd19VTnjZ2mhHLkexah5jIgjtZjj4RGgDnOHroKZFOKPCPjmn4xMELqWAmSgNOMPLy77JkXffG+MRRs+ndiEE1N6XWGNTQGVF51uBbawkhOdwOdKarIzES14l8Ivz6cz+JMZQJiWh2TSraFSmupuuOh9+FsWehYuv3zvWiz7dA8ccSDoxM/SUTM652vuY+xN34iw1tBkq5RFdExsUfFGEN0piE9JIroMSkcUVZDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wGI+ygV4ZrChr7WdeRxqwnXhpOfFlFMPPiaKAhupLk=;
 b=e66bPPjxWmDRi2m+C0YhMP6ynX/3CqvOlVylIDCZFxN1poza9vDVjbxXcAw5MHrQ7R9DXLdPmZQd7qlUhWFuMQ7r+T+sQy+zXiZllifeu9ZboQOSriyUP5hJssrZ0Dqd0wECNbXpd2EtmrbmX8iIBg+kwboNKFX7qy9pLwEc+fY385TGVIDZUDvS1o1JqwJuztDSf6g46MCuAIs1Uu+tBATHpneeAmTaT7nq/fyDvSqhFdYMYi6bV5SSc1nBxDZiB7JuKYR2MiHzBKyDuqWr6+/nMu0zaGnhzmM2ivEIlWcmbp+1Ua+oCv3XYoShd4hbe9/x+hzSG8qW4laDlX7bcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wGI+ygV4ZrChr7WdeRxqwnXhpOfFlFMPPiaKAhupLk=;
 b=shuVZFPHht1L9ooPZbW0t7qWICH3F0MZKX/Id4t6qT2Qoy9K4zIC8q8h9P67Gb0Bq0VvlVf1Hdc9rOLdj7sAoeVBoQA3DEYYhTk3G96BZzD+Ntxrlo6YA2xybvUqYTHhbfz4mZp5T+RztQ4FXzhpviRrupyF9Ih6Cl0jTCY5UjU=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by CH3PR10MB6835.namprd10.prod.outlook.com (2603:10b6:610:152::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:19:17 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:19:17 +0000
Message-ID: <78bc10b0-9376-0d21-4d66-0099376666bf@oracle.com>
Date:   Mon, 15 May 2023 16:19:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 09/14] x86: Secure Launch SMP bringup support
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
        trenchboot-devel@googlegroups.com,
        Ross Philipson <ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-10-ross.philipson@oracle.com> <87h6shbf76.ffs@tglx>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <87h6shbf76.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:408:70::25) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|CH3PR10MB6835:EE_
X-MS-Office365-Filtering-Correlation-Id: 6190ff94-c445-4e19-3c77-08db5581a8a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 96m1yDQaC9pUMNQ3u36IjAe4PHeiR97Ct3uar32WfUk/S9br7LJMoO+Lk0hSYqXlyjw3dU14iqZEzfjr8HSiBtxvv7DdXmtDDd7pU/gXRh5M7YF6R6qKyB5ndYtnfNVWQNbWrHJuoZ0M6ouIvDDHqYl9A9HWmKJqPvRjilFzPtkjpcRI0HBh7tpwGiXgOUU2A2vRb8BNw76HDGahojFXEidvw83gXauTf2D2XyNmA3Mm8BEGgkkQqYr4HXFIQSmawJxpc0D145fu92cHwYs1Inkxn3SLJXsDBoWRta5WVnLn7pK5Whux5tbb9lXfuFjhFHJvy+u4thnXfvkcutx7G1ZNGA+sOyRi95LHF/N5ooDRRNhLb6RNlILt03KXtJ37cQw3oe+Y0yFAFehAuDvdpVZbQsOCJwIjmckECi+f1HsJRwVx7OmOqEfiQdsgAj2ARNqEMnrpMSbuXl8meYe6ZO+AIvvQFyqDW2sWv+bfhr6pjfJaFInqIYSQBDwaZLLvNWDCUcpVFAchOTaibGR6JWTrfT2fEf2G3XIbuEWi6r1DHZyX0bisn7L+rzdQDE5EWD4rm6WU6FCSskPqZcX4sj0MothIoQvzfn7he4Yl/ZraJNt1aswNS+KwNJi5Rcf8aEc6z71xk4XVlGOTNdv2BQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199021)(31686004)(66556008)(66476007)(4326008)(478600001)(66946007)(6506007)(53546011)(186003)(6512007)(38100700002)(83380400001)(2616005)(36756003)(8936002)(8676002)(2906002)(6666004)(316002)(6486002)(44832011)(31696002)(86362001)(5660300002)(41300700001)(7416002)(107886003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkJoNHlCUHZZNmFQbmNKWmFudU9PYVczNjkvY3hJVlBwY0hCVmZia0hsaVMz?=
 =?utf-8?B?ajhncnkycDV2MkZwcTZLRmtHckx2Z25JS1c1a2hud2ZGY3MvUkhOWk1sTnRs?=
 =?utf-8?B?MW5wYjBkZmk2TFRpVmlEejcrYndlcWl2M3JkazI3MFJpYk5SUzBmeDBVY3Zo?=
 =?utf-8?B?RnMvZ1hXSFY1aTRycE5yTXRJUlV5clh1cUM5MmU1RzZKWkw2S1hpSklRaVhB?=
 =?utf-8?B?UlhUYW1mUGtlT1FSYWdvTkRuZVZYYWZVMlZJdkdUaE1VSlpDcVBuV3pyNEdt?=
 =?utf-8?B?UFUybkdLY0RQZDZtekhNeTNzN3pHeG9BZER1Vll3UkhqUlJmL0tHeDdpZFJv?=
 =?utf-8?B?bjJpejdwMXVpL1ZxOTZYdVRzcUhWT1QyWE5RYSsyMnU2d01lampEVUtIYmM2?=
 =?utf-8?B?TlNYeTdHdmpRdnVtSXRHNkhVbFBaVWsyYmdHa1Q5alRwbnVERzNXbGlUM2lL?=
 =?utf-8?B?eHBKOEhZOFdLNTloSjdXMDhnSGtEeHJvK0VMMzdlVFNZeDZBaE9uTUhiamZu?=
 =?utf-8?B?d1RuVjR1WWhwa2g3b3Q2aEl5dUV2RnIwdm51LzcwTlkvZ3c1blZ0NVVBVXFS?=
 =?utf-8?B?NWhPcE52VFd3ZitwTWFBYnl6VmRSaExJa1JMTUt0VVlCU2lQMXRGTjIvcFV6?=
 =?utf-8?B?ZTljbUgvdzB4U3NrUFZqUTNrU2poNURLSkEzME0waUdMTTh6UTVhbmpFclRr?=
 =?utf-8?B?U2xRYUx3ek9SWkdKZngwVm15UmczL2JyWVhUTmMySEQ5WWZNYTJwTk9HY1Nq?=
 =?utf-8?B?Q3JCQjJMTmNLbk5SRHZXczJLbktSK0dhK3FRdTBiK3VtZXd1NmxrNDc2Q0dI?=
 =?utf-8?B?N09yenlOdlpLN1Rscjkzd1R3VXpGU1B6YXRGckV4MFlab0xhQ0tVaGFXbkdl?=
 =?utf-8?B?ZU1KNHdlMEVnTnpEZVJVOFNQVDlCRXpsam44N3l5MXRVdEdJS3NHWkVnZlJP?=
 =?utf-8?B?azllTTc2VGJqWEJyUUhmM0VhTFVjc0d4b25KYjFhSzQzQlRmWTVseUo0RE51?=
 =?utf-8?B?VSticDR0ZUZvWHV3dTV2T1cvTmtvSGg0V3NOUDZ4QXBzL2lKdEloRlR0Njhq?=
 =?utf-8?B?UjBLSHR2d280MW9wTDRWdWxSRWo0OVRoNjR2Rzl2TXFQQ0RublBFekJRc3hn?=
 =?utf-8?B?ZWFLWk9oTTU5Z1FEU0dCZU42bUd6ZzVhZmRmdmRHWGR1RjB2eVdGR29kR1hW?=
 =?utf-8?B?NURpR040aUNiVzhyaU1oZzR2UEs4VHZhS3RZdXBOT3dNWURyMnhjZlhNelpF?=
 =?utf-8?B?S1dacDU0MnR6c2tyVTBGRFUzcWx6YVY2eHRkZzdLbHowYXEzRy8zdjRtS3BC?=
 =?utf-8?B?N3ZGUnc2RGcyeFpablhEUVd6SWQvK0cxRm5BY3l0cWRDeEZkZXdkd3BVSEdU?=
 =?utf-8?B?d3JNTlUzOVhpNVRSeDRsdHpZd285dXQvekd1VjRMWi9ZZUs0K3NhQ2M1cGJa?=
 =?utf-8?B?dk9lbWtpYUo1MHdmeVJScUViMEhSS1c1cXlWSldJN2tSdzRIaXB5UVo5cEkr?=
 =?utf-8?B?aEVERG9YZ0dYOXU5Tm1waTFsOW1oVE9BR3lJV242SHhUcDFiUEtLNFY3OXNx?=
 =?utf-8?B?ZjJxZ2F1Y3V6Zkk3aTkzMW9NbmFYeXE4Wlh6ajJhRVl6N2h3WTl5dUZLdGJI?=
 =?utf-8?B?SHl3OHJUSm5sNStLT3VGYW0yYUs4VjF5TEZ1ZmYycGxtNFh6enFBYnBpL09n?=
 =?utf-8?B?QlQrV1JMNGxsOGhrRWtHaEo2aTJMbE4vNUdLdnVMK1pGcGsxR2VZdTZFTjRq?=
 =?utf-8?B?aTE3UStXQ1lJdHVFT0JHcFdDK0lvNi9TbzF3K0ZQRjkvZWc2SXJERTVRYXdi?=
 =?utf-8?B?Q1R3S2N4blRKTURoeDhnL3VDZUwvM2RlT0NpMkNKay9hYU5Qd2NPTnJ4Y0tx?=
 =?utf-8?B?Q05TekZwdCs2YTBiUnB2N3lXbktxR2t4c1FvMEdreXRESkJWeEg3WXU4KzE4?=
 =?utf-8?B?RmZ6V1Y1dlhWWEhrbmpwdDByTXppSHpzaUYwMHVnZTZJODh0bVVwLzBoeUpG?=
 =?utf-8?B?dnRWSXQ5bUhXK2R4UzJEU0ZrY0NTVkpJUHlUelluVlZiVXpnK3Eva0hXdE4r?=
 =?utf-8?B?NVVZekVxOG50UUJwdTFlV2ltMW01emdwanBSVk9nVGhaZWNaRTNPNlp1TEk2?=
 =?utf-8?B?NGVsR2NrRjFGVGVHWjJnSkZ1VGp2bVVTWkRXOG5lZ3ZJR1pQSUc0U3NueDF5?=
 =?utf-8?Q?2O6FJKjTZR/rHvNKJb20Dk8=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?QlpxMzFhdU9pZmdrcUZEdFkzN1dIR1NScEQyR1d3RW5WQTc3VTM4Uk80WHo2?=
 =?utf-8?B?bXRyMSs2T2ZwOStKdzdYcHQ2ZG5Zc3ZmOEVyTEhPcU1FZ3E0dG5iQVZ0N2tC?=
 =?utf-8?B?cFZLa0prbXZPaHRyRDRUbnZZOTZiNFcyV3ZkblAvZ3dTS2dIUWFmQlhTNkxx?=
 =?utf-8?B?MkEwMndhOHV3UldZU3BXaWlQTWVSTnRXKzFVYkozaWNkVUdmNUVySThGNzFo?=
 =?utf-8?B?MTdBSS91ZEIxeFFQR09nYUxGY0o0ZldCYzVnd0o2QWxzeTF3NUl4NXJXWmY0?=
 =?utf-8?B?SFFsQWJYWllQSDNLcHlGYWxZT0RWQk0xNGJLZTRHUVZlK21lR2pQK29RTHlW?=
 =?utf-8?B?S0JkdnY3ZlZSTlMwUmo4S2xBM1ZWYThqWGVGem01eTl1MWZibWRjUmVqY04y?=
 =?utf-8?B?dHJPbHJldUFqZmdodEMxN3d6TXVqZDM1TFhSaDlNVHpSQ2hhUVcyNTJNVnVC?=
 =?utf-8?B?a0N2SVQ2Vkl6d0lpRnB5b3NJY2tlTmlJM1JuejBMZ25ibjlDUm5WSFJEZGwy?=
 =?utf-8?B?alJzRjhHcUN5d0lKOWVjaERvWmlHL3FMbG9waUE3akhSdmVrUnZ0dGYyekhT?=
 =?utf-8?B?clF4b3d4K0NyT3hYVE8wVElzalJxb3UxNFoydzdydHlTLzhRZFpwK1pTUndx?=
 =?utf-8?B?TnZOSjhGa1BNQlNZQm5mVlNZQnVxT3RMZm1CSlM0OTZYa2JRVUUzSHFWckJI?=
 =?utf-8?B?QzhYRkltVHgveE9HTXh1NEdlQ2VhVk5rSDNFSzI5ZzZoZStrWnBvdlowWUc3?=
 =?utf-8?B?V0dlZkVjVHRYNVlmZ0poU3NVb1h2cWMrWk1JTVFRMERVZWJoOS8yZjNhRlRS?=
 =?utf-8?B?NTNUZEZjclZKTmhBa3dyb1dTV3lCK0czLzhCQ1BKcm1MMi9nMjEyUGY0cE92?=
 =?utf-8?B?UDNsQkNqcVhQeUdCV1Zpc1lBMzBoVkdhTnFGOWNYVEU1dzRRMktPODRVQ2JQ?=
 =?utf-8?B?MXlJNW5ybnNtelNWTFhxaXYxYlVoTGh5YmVIdWlGRUlOOG9ZTWFQN2dveThI?=
 =?utf-8?B?bnFhQVpOZkVQaVhlQ2I5aXZocVVzWmwwQklmaHcrV3M0d2I2VFFnZXc3c3pC?=
 =?utf-8?B?SFBYckpteVFyNEFQYkVBams3Q2ZyVUFjRFZJUDdTOVdxMXpGb0lJQkttUi9k?=
 =?utf-8?B?ME5VcnI1Z243WUUrN3RHTmJ1U3BUREh4MUdJcFdtbmIzdmducldjSFNZQU1M?=
 =?utf-8?B?c1F4eVRMa1VQVjVvMForMGdpYnNsWUxZbU4xUWlEa3NkTFpUdTBSUDllS3pE?=
 =?utf-8?B?VC9WdVBhTlZzZ0s3NWp4aFlwTGN6eHludWE2RE83d1VPS0hDY01CT2dLNm5k?=
 =?utf-8?B?Rms5TTUwcXR5T09QZXdsOUhIRGZmYnFLWWF2Y2Rxa2o0TTRFbzZRMEt0WkUz?=
 =?utf-8?B?bVcwVng3UmZHSU04a1IzSDlGSEo4R2xBbzFQcDBUR01BQ0tpcXU5ckRkQnY2?=
 =?utf-8?B?bEJXcDVlVDdJQWlsODFKN1dQQS94OStIRHdxb29uU0ZRZGJlL3VzWWhkRzZt?=
 =?utf-8?B?dUJFaTVlWk5tdENWYTJmbnRnNS9kNzFhSk1ZSlYwQkxPbW9xN21VTThQM1I3?=
 =?utf-8?B?ZFJxMkk3OHI3VHhBbGtMN0JNbytwTldDL1g1VHhOS3E0dlllaUlHTlp4eDJn?=
 =?utf-8?B?YXZ1ODFpTVhXWnE2K2o0MFZIYnBQVWc3d2poaUpIYW1xaWxiWnVVSDVFM04w?=
 =?utf-8?B?Z1JiYWRzWWZpemQ1K3NMMXRPVklYSUszZ2F4eUVyR1pxaUgrTGFLKzN1d1pp?=
 =?utf-8?Q?keAAVwZX96Su7BS6iI=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6190ff94-c445-4e19-3c77-08db5581a8a3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 20:19:17.3871
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SAOknoj6v9aypprD8Cyi3QmYjI1a1rherVH0E2+bfzLi+8BheGU396zyaEHVVagk6jcy22pfI9s7vyOHxyJfXpINfaKJGSnQZ+HrToXY7HI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6835
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305150168
X-Proofpoint-GUID: ZsSsxPq5rAIZsFqkuvgEGkgFEdqGcH1q
X-Proofpoint-ORIG-GUID: ZsSsxPq5rAIZsFqkuvgEGkgFEdqGcH1q
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/12/23 14:02, Thomas Gleixner wrote:
> On Thu, May 04 2023 at 14:50, Ross Philipson wrote:
>>   
>> +#ifdef CONFIG_SECURE_LAUNCH
>> +
>> +static atomic_t first_ap_only = {1};
> 
> ATOMIC_INIT(1) if at all.
> 
>> +
>> +/*
>> + * Called to fix the long jump address for the waiting APs to vector to
>> + * the correct startup location in the Secure Launch stub in the rmpiggy.
>> + */
>> +static int
>> +slaunch_fixup_jump_vector(void)
> 
> One line please.
> 
>> +{
>> +	struct sl_ap_wake_info *ap_wake_info;
>> +	u32 *ap_jmp_ptr = NULL;
>> +
>> +	if (!atomic_dec_and_test(&first_ap_only))
>> +		return 0;
> 
> Why does this need an atomic? CPU bringup is fully serialized and even
> with the upcoming parallel bootup work, there is no concurrency on this
> function.
> 
> Aside of that. Why isn't this initialized during boot in a __init function?
> 
>> +	ap_wake_info = slaunch_get_ap_wake_info();
>> +
>> +	ap_jmp_ptr = (u32 *)__va(ap_wake_info->ap_wake_block +
>> +				 ap_wake_info->ap_jmp_offset);
>> +
>> +	*ap_jmp_ptr = real_mode_header->sl_trampoline_start32;
>> +
>> +	pr_debug("TXT AP long jump address updated\n");
>> +
>> +	return 0;
> 
> Why does this need a return code of all return paths return 0?
> 
>> +}
>> +
>> +/*
>> + * TXT AP startup is quite different than normal. The APs cannot have #INIT
>> + * asserted on them or receive SIPIs. The early Secure Launch code has parked
>> + * the APs in a pause loop waiting to receive an NMI. This will wake the APs
>> + * and have them jump to the protected mode code in the rmpiggy where the rest
>> + * of the SMP boot of the AP will proceed normally.
>> + */
>> +static int
>> +slaunch_wakeup_cpu_from_txt(int cpu, int apicid)
>> +{
>> +	unsigned long send_status = 0, accept_status = 0;
>> +
>> +	/* Only done once */
> 
> Yes. But not here.
> 
>> +	if (slaunch_fixup_jump_vector())
>> +		return -1;
>> +
>> +	/* Send NMI IPI to idling AP and wake it up */
>> +	apic_icr_write(APIC_DM_NMI, apicid);
>> +
>> +	if (init_udelay == 0)
>> +		udelay(10);
>> +	else
>> +		udelay(300);
> 
> The wonders of copy & pasta. This condition is pointless because this
> code only runs on systems which force init_udelay to 0.
> 
>> +	send_status = safe_apic_wait_icr_idle();
> 
> Moar copy & pasta. As this is guaranteed to be X2APIC mode, this
> function is a nop and returns 0 unconditionally.
> 
>> +	if (init_udelay == 0)
>> +		udelay(10);
>> +	else
>> +		udelay(300);
>> +
>> +	accept_status = (apic_read(APIC_ESR) & 0xEF);
> 
> The point of this is? Bit 0-3 are Pentium and P6 only.
> 
> Bit 4 Tried to send low prio IPI but not supported
> Bit 5 Illegal Vector sent
> Bit 6 Illegal Vector received
> Bit 7 X2APIC illegal register access
> 
> IOW, there is no accept error here. That would be bit 2 which is never set
> on anything modern
> 
> But aside of that the read is moot anyway because the CPU has the APIC
> error vector enabled so if this would happen the APIC error interrupt
> would have swallowed and cleared the error condition.
> 
> IOW. Everything except the apic_icr_write() here is completely useless.
> 
>> +#else
>> +
>> +#define slaunch_wakeup_cpu_from_txt(cpu, apicid)	0
> 
> inline stub please.
> 
>> +
>> +#endif  /* !CONFIG_SECURE_LAUNCH */
>> +
>>   /*
>>    * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
>>    * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
>> @@ -1132,6 +1210,13 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>>   	cpumask_clear_cpu(cpu, cpu_initialized_mask);
>>   	smp_mb();
>>   
>> +	/* With Intel TXT, the AP startup is totally different */
>> +	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) ==
>> +	   (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) {
> 
> Stick this condition into a helper function please
> 
>> +		boot_error = slaunch_wakeup_cpu_from_txt(cpu, apicid);
>> +		goto txt_wake;
>> +	}
>> +
>>   	/*
>>   	 * Wake up a CPU in difference cases:
>>   	 * - Use a method from the APIC driver if one defined, with wakeup
>> @@ -1147,6 +1232,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>>   		boot_error = wakeup_cpu_via_init_nmi(cpu, start_ip, apicid,
>>   						     cpu0_nmi_registered);
>>   
>> +txt_wake:
> 
> Sorry, but what has this to do with TXT ? And why can't the above just
> be yet another if clause in the existing if/else if maze?
> 
> Now that brings me to another question. How is this supposed to work
> with CPU hotplug post boot?
> 
> It will simply not work at all because once a CPU is offlined it is
> going to sit in an endless loop and wait for INIT/SIPI/SIPI. So it will
> get that NMI and go back to wait.
> 
> So you need a TXT specific cpu_play_dead() implementation, which should
> preferrably use monitor/mwait where each "offline" CPU sits and waits
> until a condition becomes true. Then you don't need a NMI for wakeup at
> all. Just writing the condition into that per CPU cache line should be
> enough.
> 
> Thanks,
> 
>          tglx
> 
There is a lot here to think about. It sounds like you are suggesting we 
design all of this differently and we can definitely do that. We need 
time to go over this and your parallel startup series before we can 
really get down to how best to approach this.

I am going on vacation and will be back the first week of June. I will 
get back to you then once I have had time to go over all of this and 
your other patches.

Thank you for all your responses.

Ross
