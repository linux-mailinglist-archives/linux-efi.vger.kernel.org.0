Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E061703E18
	for <lists+linux-efi@lfdr.de>; Mon, 15 May 2023 22:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbjEOUGz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 15 May 2023 16:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244704AbjEOUGy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 15 May 2023 16:06:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD1710E53;
        Mon, 15 May 2023 13:06:53 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34FJsNZk031484;
        Mon, 15 May 2023 20:06:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=l9sHeX/Sg4bp2sGcS5Hr0CIiPW3GsOyyQlQpnqOkXEk=;
 b=o+cND7hEszMAW+VTm4yp5Ivkn2g3BQNM4z5ZDqU7qRFu02z6sEAw50yjaCQ5u1u5mx9O
 qw08Ds67qXdd/QcRYVIVAz/cPbqeVrZq8FhmliXkJm3dBJx8Ecbn8qypgxfbkGy6Ux+q
 aUZVM70gw2HcWrjXe24cRihj58RApnk1OFh78e+iGwgImpUNjXyEz9s3ZLbHLaQdBg0A
 98isJ6EWljAR7ZiY7L3mzyGLSyttvmOfgZu1li0fGQgglpLqWMhlCeIPTXB59Kf85lqL
 oY+Eekz0qE0eHpCo2r/O7qHd7BMGUPz6fHXJJtJGm8mum/qsZyU528qVBZ9m938xIP1Z Vw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qj15215km-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 20:06:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34FIZgOT029441;
        Mon, 15 May 2023 20:06:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj103542p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 May 2023 20:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqst2Sb60ugTZppUYRhQuFcnxUMXEgeLhPWaVIHOb6VjuB5KysNzo6ejB7WrlTvsAhXGth7Zyu/O/7lc8kMWbdF3GXRIALkcyBwPLxoLOpF1uZS+W8PwYYri9Pk9ouX15IhbYufCmcdJd2Padw6KlmGGWgQViJLklZDlSk9D1bGfUzuyJ7RmrN33mslDo0cD1Sk0XpHN0BtTG6ZRmDD2xQVVX8pXp5FVCz/2WMUQZ1OfgrDfdAnHa09n89NqvoP098bFBik6g35XOhg7y5DPV8xbJug0+B1WL6HVKnVx2/Qg4BK0lKvjhMcjMhs6VJaSP4So4qO7LtNNHPSvoxob2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l9sHeX/Sg4bp2sGcS5Hr0CIiPW3GsOyyQlQpnqOkXEk=;
 b=FfRR33R+9vOrGflTrFKKtCsRPfI/wIVo7PUmTw1ZOi+gX0tu0g1ugOnxLu+IXWIzsP+c/Bd2MIEtNrRvpL4QzQQoF5Ys8pm0a3UqSMeaS5WAch49lgvgrhQgF2a+Sduyp0Tt8y5x1c/wlYRjRH57stQbBdO6lG9XY4nZGSKRxZt4+OvDSmA6BMcHZZRcMtcVI04eAQzaqNh33YHYR7d5UnkYFyff1s4MqFfAXmykbxRJ3OqjSKZ1SkPh/5zwyZe4W34O9KkRARpiRfgF3KWQsnwLcbYI35mT92LI/3ZrCmNVbt1Bz0DIs0DMd+EGSWTTDu20SxwH+jVIiNSkTetbVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l9sHeX/Sg4bp2sGcS5Hr0CIiPW3GsOyyQlQpnqOkXEk=;
 b=BiK3PnFeiQrFtiAvjvgBtyqRNer9OS+LIJUpbBkThgrZko2MitCLapfzA7Fsjmgi+AgY7NYKASD224zPr4lypoh1WbsFzR5dRZ/fAtGfdqkrAYLjuWEiCd6+0FqZrMl58ojq3FCR3mlF3CDDKOYM5URV1Z5C5FD9wgshPpPiIF4=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by CH3PR10MB7305.namprd10.prod.outlook.com (2603:10b6:610:12e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Mon, 15 May
 2023 20:06:14 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91%4]) with mapi id 15.20.6387.030; Mon, 15 May 2023
 20:06:14 +0000
Message-ID: <95704ec0-698e-2ddb-308a-2bcc81b81f46@oracle.com>
Date:   Mon, 15 May 2023 16:06:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 08/14] x86: Secure Launch kernel late boot stub
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
 <20230504145023.835096-9-ross.philipson@oracle.com> <87jzxdblmn.ffs@tglx>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <87jzxdblmn.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:408:70::14) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|CH3PR10MB7305:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d020391-b747-4b87-d93e-08db557fd60c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FL23YWqfQlUW47YoWPBivYuv78ZQ3p2YmhqwWzQlcr+mVw90Bb20EoZkWBc8AfCnkcpQJZBSEtu0hByYVigl6773+3ttQy/9dfkMGo1zFng5iB2sxsb9yCafH6ofiC78rkJMVvik04lBk9uRQdE/dRc+GqgD0zpgWVnOe14nJRgUhuIJ13WQ1NL94FjCErm6uqqhEwu9SxMjhAGD4Xh1neGez66KmccLOmJn//OTlXmnq0voJOCGf2ijyMjdeJ0kXEvvLr5osTC5/BwKcDWpxEo32RxV7dYbuTdLSYvUoLFLdqV2nQI75nnQF2gMzOndAcE5RPLyThdWB2qx2GI0pzGb68d3WLxVd2PEubqVwkZmlES9kMNK4NGSwG0+z9aHF80vaeAyngQPEgzwapIjLl/DzVb2G66F1RpSFpsIY3VIpo3yHJCSEj4JwdFBU7o0eY/Db5GoYFUm0xcjvejTvSvGbXrYb2VBy1Be6Sd5difECEhgI8pSQM7x7aTYWwzFwBMpq0PSgH1AYNQLrqiQgKFet96tkndiWbHwL03mL+UGRsBIGizm0AyYnthoCR79j/SumxUqNAK87ismHiZTlZZD7QJ+wy6cujTaf1vIrL2pc4bp6MONCL5VwNHyRafNcRhZ/sR34BVFjkOAD9g27g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(31686004)(83380400001)(4326008)(316002)(36756003)(41300700001)(38100700002)(6506007)(53546011)(6512007)(966005)(6486002)(478600001)(107886003)(66946007)(66476007)(66556008)(2616005)(86362001)(8676002)(44832011)(31696002)(2906002)(8936002)(5660300002)(7416002)(186003)(6666004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFd3d1RMejNZWjdvaXUwZVJlNGpjelhTRGlXVlU2MzEremo2MGh2WWxxdFJO?=
 =?utf-8?B?aEcyMjQ0QXYzZHlZS1gxVlNERGVGU1FLVlk5cjhWTnh1YzErZDgxMkwzRmhh?=
 =?utf-8?B?VTdQOTVVM0ZrMjJOYWRtUkVFWDZJMW5HcHV5WDNVVDg5VVk0SzM4bEh0eTBa?=
 =?utf-8?B?M0hXZVJZN2xCMXZKWFZCajJUdHQvNXNQdDBTcEZvaFIzRzNUL0lmditWS0Fs?=
 =?utf-8?B?ZENRQzRLZVF4VkRzWGJyb290d1J5cjI4MTUvWWtzNTZNRmlSK1dpZzhueVVl?=
 =?utf-8?B?UVJGZFNZMi8rc0NXaVA0U0o2bUY0aVcxK2JZblNpNVNRR0lxUDZ1eWYrNkIz?=
 =?utf-8?B?N3NPbW9TTE9ZUmZpSlZCelBlcnVGdFcvY2xQRHh2RnhWd3ZST0w5Qi9kYUhz?=
 =?utf-8?B?d1g0RWZnbTdzWHpYbWFwTUIxeFNHL2RLbHM4M2MzRFhGWnVDNkFMS2pwSWxS?=
 =?utf-8?B?V09GYy9qV2dLWjg2V0tzcXQ0QmVocHJGMlZhQmhJajQ0bURGZklEMUtFWVlP?=
 =?utf-8?B?cnRkYVg1c3hLUE9rM1VvS0hWK0tZQjE1R0diWDhRMHZhVHlDeGprN2ozTTJp?=
 =?utf-8?B?cnhBeTg2WFRoTUEzSUUxcjBEUlZ3ci9IYmRxMERSdHV6a1VpOHJEc2oyZ3ND?=
 =?utf-8?B?QjNYd0hjdXE3SjJYcWdIbnNvSktHbXZDRVdwSjFHWXVGWTFjZlVFZ1g3VURk?=
 =?utf-8?B?cW5kRThDT0wycDRIRFBVa3FIQkNDR0RVVmZIQmpuUUJDY1p5U3BXSTNSemE3?=
 =?utf-8?B?VFJOb0YwSWlPMkJQMUpFV0JTTjFaa0ZSek9MWndOU2FTa2hjWXEreHpKTW9j?=
 =?utf-8?B?aE1TN0krL3I5dkJxNHNaVENVN3ZTNzFoVWZ3R2hURkp6U0F1eWhhVlVHWUlJ?=
 =?utf-8?B?MS9tWEZjR0xpNVEwaGVFV3ZyTXRQSk4yQ05qOFI4MDBTVEliMG1Rb0src0hE?=
 =?utf-8?B?Ynl1RzEwWkpQT283VXhSVTN1YWRsMHFmZXJ0eVhBT1Rzc0cxZDkrMlVvRTJl?=
 =?utf-8?B?bWJFbEZyWHMzRjlGb24yd25JU25mb1lFQnkrK2N6Vy9lSC8wbnl2N3lneVpO?=
 =?utf-8?B?NzI3NG1YNjgwRlhRTURrMlFOZk5QREZpOHFSZEVyWGU3emNYMkZOL2lESlpz?=
 =?utf-8?B?VmRlOTVuck55bmI2VGJBR3J2eno5NUhPT0kwWDBzcUJSQUwyYzJrb2VSUGN0?=
 =?utf-8?B?dXNZNXI4d2pJWU1uL2JROC80WVpxTnJ6dHBKTGFYd1hhRWJEbkU1bGcvYUVh?=
 =?utf-8?B?OFgvcENPQXkwTWxwUVQ3RHAwSE0vVkFwVnZYNXE4NTh5ZnU2UWpwSWM3aFRh?=
 =?utf-8?B?b1JIclZ0Y3lEQlU4OE0zTnFJZzc1WE5nQmMvMmsrSnhpbU1tbHJqY2dPZ1Zp?=
 =?utf-8?B?TnpiMndvSUdZZTRFaE9BTXBQT0NBM1Vnc2I1Y3BpUGNTQWlHTlp0MWVVYklX?=
 =?utf-8?B?RGYxeW43RnhXM1Q1UWc3Wlc2NGJLU1Bpd0dnMFhPcDJBOFduNjArRFhxTDhD?=
 =?utf-8?B?OXpuTlpqSXNXaUJUNFJzOUt3S2lneGFCWjN6WmxxRmdHMkVmRFdlMWtSNjkr?=
 =?utf-8?B?cDFMdjRadjYyeVFWUnArTlVVUTBqYThWYzFhTktWR2s0a25VWElEdGhoNGRz?=
 =?utf-8?B?c3ptSEhWa3FPdGorTjlLd1hqTEtuYXdsRGdHSkxUMEJVN1dGRVNjL0tIWHYw?=
 =?utf-8?B?T2NYRnlrcFRxRG5ycWlsSjdPVFNiM0R3T0o2dUJpekZYa1JzL3lsUWNkcUNI?=
 =?utf-8?B?SGJoekEzcUljRzArbzJmd20zRXhTanNxTHNzM21rMUhWMHN1NzJEQ3ExY21Q?=
 =?utf-8?B?eUhxT0FUcEpGRGVxUWF1aXpTZmsvZGJsc0Z3NjFNeWswSTFMWE9sN0QxR0M5?=
 =?utf-8?B?dU1nWUJrTnJHZXcwWUZCTk1pR1NqNXBVcGNUbXh2VVVxbnU5YUVkTS84N1J6?=
 =?utf-8?B?WUlBWTF3a1h2UUd3NGdidFZnVzZKVFVJYWpyc0xRVnpqTGtiaGxpdlFud0hJ?=
 =?utf-8?B?andxWHFzRm9JSjZKb1Z6SHgrVWVhclM3K3k0MitiMGlDTWtJODVuMUY0Qmp0?=
 =?utf-8?B?MVBYR3VMdXAxSEoxaTRlSXlxNGx1djBiTk5GS0lCVXZISmNNc2dmNGhVUDc5?=
 =?utf-8?B?c001cmdnTUdIK3ZsbnhjZE9lVDdGUXBQeCt5bWxRZ1c4SjZac2xmVjBWVWxZ?=
 =?utf-8?Q?beKhdufdgJC4vQpSoP4UsA4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?Vkx6MmRwYjQzaDZsMjJkeElaRnpEcEJqdkF5N2MxdlVvNitwdTFxcWlMeWx6?=
 =?utf-8?B?VjhMUGpPUlA4bERkTHJmMlZNYXF1N1NVbnR0YXVwMUs5OWhRdXduQkpVRnNo?=
 =?utf-8?B?Sm1SUi9mZllpV0Z5UG16Z0QwTkNjMEp5c0EwWUJJbjQ4cXBxTWcwbWN5Wm1D?=
 =?utf-8?B?UU5vc2VXTHR2bTVRNVlkRHA4VVMvQk1NQ05DZHJqQ3RjMmNPaWMyWVhXY1pl?=
 =?utf-8?B?d3g0K2NtUnQ1c3BSblc3Z0R4bExJTGNVWkZmUXVmd3dYcHBzdlpNbVhFNUZN?=
 =?utf-8?B?dHRaNzRIditwUll2OU5rdE05RkhwNnpQRnFlaUpyY0RnT0l5THFoYTkyYkZq?=
 =?utf-8?B?VjhzWERQekVDZ3RqKytZd1pvWFFFVXFTY3BzQXFpNG9qbk1sQ0VtbmFLbVlZ?=
 =?utf-8?B?bUFYcUZVK2hJT3JlS3lWV0Vnc2d3SHdHektzUjJTQ0k3VzZEY2NJYUxINTBS?=
 =?utf-8?B?WTJZTmtWV1JnTFpRVnNDUVBNa0tVRnRQQld2blRzRVVESG1iemFkdU5aeTkv?=
 =?utf-8?B?Unk0b2dpZWh2QWN1NW5pdWpkTVdSNzE0SSsvNTlGOWEzUUJzdGJ0L1pJYlYy?=
 =?utf-8?B?YmR0cmFvajkvSm4xUWtKVFNLQUx2RERrRjhqaGgzN2w0cjN6a2djNnJTaEc5?=
 =?utf-8?B?VVd2RGYza2FER1hnUUZTak8waEwwYmM5QlQyb1Y5Z0dwaW1YeGhXZzVjMC9R?=
 =?utf-8?B?YXdMYmdsem81LzNicmJOLzdTVTdJam9BOEFJMitGOWlsd3Rrenl5SWhkWWdX?=
 =?utf-8?B?VitxVTNKQjBlakFsNmJ3N1JjMVJSVTBSbXo4SVI4dGFIa1Rlbm5jcGV3Yi9Y?=
 =?utf-8?B?eENxUlUrWmhiMndyNzEvSi9MZ1JGL2UyNzJ3OUVoWmc2SDE1RVM1STVnbDFs?=
 =?utf-8?B?WHAvYkswdklObk1NZjA5cnc3L2Jlc3pKMXB6UU94anlicC9Jazlib3NZSThv?=
 =?utf-8?B?TkNmZ1FHUncvOXNXWXZJblNjTk83WVNudmFRLzFTdmgxblRWaEswZ1h3TUJl?=
 =?utf-8?B?ckJiTUZXMVVsRmZJdkFvNG1yWHlpNHNUV2ZCSnN5eEtadXppNTJnbHY4Ymw1?=
 =?utf-8?B?d2dsbzkyY3JJTmhXV29ReCtibHpyZW1lM1BKQVpVRXpnekVyZVd2M2NteEFy?=
 =?utf-8?B?SEtLWlZSSkt3dmJjTVRVSExKTkJaREFPbzRkYVlsQUFVSUk1VHgzMWpndU8y?=
 =?utf-8?B?RU5WTi9ZUXJLOEt5d3pZSCtwdFlVRzZ2LzVjdVk4ZWlxTnNpMklrY2pXMGZM?=
 =?utf-8?B?R0R0OHFPaEpwZkZiOURIengweFZ6dWYwLzdTTFNnb1oweis4T0VSbkZPWmo4?=
 =?utf-8?B?VGxrVmYxdHozQlA2azFMZktNL01jTmE0TDVKazRnWENlbnlFTUZuYTJDbHdD?=
 =?utf-8?B?dklGbnd2TGZoMGpuUkhVa25xUmhaWGpwd3dFMGVhUDNHN0xHZDBNbHhuMWtp?=
 =?utf-8?B?V1pZNDBMbTVDMURoVmhKQnhQektZQ3lMb0d0ZGxQTHJPZHc4eUs4QnRYOXRk?=
 =?utf-8?B?bU5mbUExdUlxVU9sTTZQMHR5VjlXd2VWZVplZkxURWJKQk1LRWxxZ21DOVFz?=
 =?utf-8?B?UmlYRlZhQmVXY1Rudk1CbVhrSS9pTFQ5ZEtBQ2hwMXhVQ3V2U3F2RmxURFdV?=
 =?utf-8?B?Um1vTFZUeVU5SFlqSTlsS0E4U1ExZk5Od3I0ZE0rQXhpR2orelJDaTBaNjRj?=
 =?utf-8?B?TkMvVytLYm90NE5NRmw4d0dkNTFlbTljdGJJTFQxM1ZFeGhQY2tOYnFBR0x3?=
 =?utf-8?Q?xoMF/UmkZ/242clZC0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d020391-b747-4b87-d93e-08db557fd60c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2023 20:06:14.6271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaO3Thh9fFPyobOJAFG7Tb8EEx7PD9aOY0cqCleKi375WClfA1JtnBBGLGxD6nlyyq6Z2P11kL0BFNdXlqaVS7+kEf0NFe/G0tj/Co9AHT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7305
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-15_18,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305150166
X-Proofpoint-GUID: HmhxvvxHEzCJRn_tEcxbKSay0b0xkkGy
X-Proofpoint-ORIG-GUID: HmhxvvxHEzCJRn_tEcxbKSay0b0xkkGy
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/12/23 11:44, Thomas Gleixner wrote:
> On Thu, May 04 2023 at 14:50, Ross Philipson wrote:
>> The routine slaunch_setup is called out of the x86 specific setup_arch
> 
> Can you please make functions visible in changelogs by appending (),
> i.e. setup_arch() ?

Yes I will.

> 
> See https://urldefense.com/v3/__https://www.kernel.org/doc/html/latest/process/maintainer-tip.html__;!!ACWV5N9M2RV99hQ!IpJMDBpAvJRDAh0tZI_nMv0zZqwQDnxFjBEKRitYq4JU-iV-NnXg28lGtTwb1ynVA4XEy5n9aSdIekxkztyZ$
> for further hints.
> 
>> +static u32 sl_flags;
>> +static struct sl_ap_wake_info ap_wake_info;
>> +static u64 evtlog_addr;
>> +static u32 evtlog_size;
>> +static u64 vtd_pmr_lo_size;
> 
> Is any of this modifyable after boot? If not then this wants to be
> annotated with __ro_after_init.

I believe you are correct and these are never modified after boot so I 
will do this.

> 
>> +/* This should be plenty of room */
>> +static u8 txt_dmar[PAGE_SIZE] __aligned(16);
>> +
>> +u32 slaunch_get_flags(void)
>> +{
>> +	return sl_flags;
>> +}
>> +EXPORT_SYMBOL(slaunch_get_flags);
> 
> What needs this export? If there is a reason then please EXPORT_SYMBOL_GPL()

I think that may be incorrect. I will look into it.

> 
>> +struct sl_ap_wake_info *slaunch_get_ap_wake_info(void)
>> +{
>> +	return &ap_wake_info;
>> +}
> 
> If you return a pointer, then there is not much of point for encapsulating.

I am sorry, I am not 100% sure what you mean.

> 
>> +struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar)
> 
> Some explanation on public visible functions would be really useful.

I can add that.

> 
>> +{
>> +	/* The DMAR is only stashed and provided via TXT on Intel systems */
> 
> -ENOPARSE.

I take it you mean you don't understand the comment. I will try to make 
it clearer.

> 
>> +	if (memcmp(txt_dmar, "DMAR", 4))
>> +		return dmar;
>> +
>> +	return (struct acpi_table_header *)(&txt_dmar[0]);
> 
> s/&txt_dmar[0]/txt_dmar/ No?

Just an old habit. I can change it.

> 
>> +}
> 
>> +void __noreturn slaunch_txt_reset(void __iomem *txt,
>> +				  const char *msg, u64 error)
> 
> Please avoid these line breaks. We lifted the 80 character limit quite
> some time ago.

Ack

> 
>> +
>> +	/* Iterate over heap tables looking for table of "type" */
>> +	for (i = 0; i < type; i++) {
>> +		base += offset;
>> +		heap = early_memremap(base, sizeof(u64));
>> +		if (!heap)
>> +			slaunch_txt_reset(txt,
>> +				"Error early_memremap of heap for heap walk\n",
>> +				SL_ERROR_HEAP_MAP);
> 
> This is horrible to read.
> 
> 		if (!heap) {
> 			slaunch_txt_reset(txt, "Error early_memremap of heap for heap walk\n",
>                          		  SL_ERROR_HEAP_MAP);
>                  }
> 
> See documentation about bracket rules.

Will do.

> 
>> +
>> +/*
>> + * TXT stashes a safe copy of the DMAR ACPI table to prevent tampering.
>> + * It is stored in the TXT heap. Fetch it from there and make it available
>> + * to the IOMMU driver.
>> + */
>> +static void __init slaunch_copy_dmar_table(void __iomem *txt)
>> +{
>> +	struct txt_sinit_mle_data *sinit_mle_data;
>> +	u32 field_offset, dmar_size, dmar_offset;
>> +	void *dmar;
>> +
>> +	memset(&txt_dmar, 0, PAGE_SIZE);
> 
> txt_dmar is statically allocated so it's already zero, no?

Yes. This may be left over from an older iteration of the patches. I 
will ditch it.

> 
>> +/*
>> + * Intel TXT specific late stub setup and validation.
>> + */
>> +void __init slaunch_setup_txt(void)
>> +{
>> +	u64 one = TXT_REGVALUE_ONE, val;
>> +	void __iomem *txt;
>> +
>> +	if (!boot_cpu_has(X86_FEATURE_SMX))
>> +		return;
>> +
>> +	/*
>> +	 * If booted through secure launch entry point, the loadflags
>> +	 * option will be set.
>> +	 */
>> +	if (!(boot_params.hdr.loadflags & SLAUNCH_FLAG))
>> +		return;
>> +
>> +	/*
>> +	 * See if SENTER was done by reading the status register in the
>> +	 * public space. If the public register space cannot be read, TXT may
>> +	 * be disabled.
>> +	 */
>> +	txt = early_ioremap(TXT_PUB_CONFIG_REGS_BASE,
>> +			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
>> +	if (!txt)
>> +		return;
> 
> Wait. You have established above that SMX is available and the boot has
> set the SLAUNCH flag.
> 
> So if that ioremap() fails then there is an issue with the fixmaps.
> 
> How is returning here sensible? The system will just die later on in the
> worst case with some undecodable issue.

Good point. I don't think I can do a TXT reset at this point but I could 
panic.

Thanks for the review,
Ross

> 
> Thanks,
> 
>          tglx

