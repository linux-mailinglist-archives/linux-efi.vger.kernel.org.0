Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB626F8934
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 21:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjEETAo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 15:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233430AbjEETAl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 15:00:41 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCEE20771;
        Fri,  5 May 2023 12:00:39 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 345Hhaup028946;
        Fri, 5 May 2023 19:00:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=R1k758Oaau62w21jw395tFMtBwEYwj0L/Y7+MjlUAyE=;
 b=LP520A9nL5gCEqHHoaUNCl6bZQQ2ZJ4ninDnzSxYUwnjYRq+RN83CBxcMs9m71KQd8N/
 vC31IT9k0//7Wiuvaw1MwJVTvLEe+uK2/er2Cx65/fxrLzblcKCJqlQxsHAdeK8h94BO
 Wr4x7+R0aXnkprqKnGTLEq7O+A3BTWJYrSCkvrG0kuDbGOvdO08OK7/oxKw85ufd99aU
 ybNPnMPWpbWO6ySYHucwVUmoqN0wFYUnnAAb7M6gQn75GpPMSypasrJtKWW7UqUdDoZ+
 n1o4c/cEd46D6mgb41Wbf+XF9a5JhvCjs/CKUz6WRDDheAtg1tvyia+GIeKDEI7eRvRC 0g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q8t5fwk9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 19:00:05 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 345IU6RM015313;
        Fri, 5 May 2023 19:00:03 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3q8spghas8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 May 2023 19:00:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaHPVmiigtmwvOPs8G+ljt31WRpStkCDsNKGoDAQS7xcbpxW5rLXarGM+VJnFycAxo2paXE4DInGvAzO5qPE4kHmS2+loiSl1O3N8rHUcrhAPtsUJ29fC0IeLjdtoVWGJQKf0HYJlTtACYfMkIlW9h3q3uWMNKZT2EGgMWfoe6WyNZcDJ9I5jtIpJr4wZIliOPPaHzDP1tGOROI1XbgRR2aVspyKGD3Be1oHecHJY219wefm1F9cRcuDh+i/K0tfl+m9LAyMYS7ZDQO57ZiZOwvDdsJoitwKXhNY+kLJrXa9Lfhrn7xQGdiQxq+/Vs/Yb2WBmiOJ3qMrGyMIZBwNEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1k758Oaau62w21jw395tFMtBwEYwj0L/Y7+MjlUAyE=;
 b=DXrR0xBFo5yzX3QbSR59IVXaDTJvJD72ZHutmdPt52EGV7/H5c3TJMxdvAi+zG28eWIbaAgAHzJvMOPUmbdkHpwJJV/4RfaGlVNHZnpSQhaRFS2JPRHLipJ1y61leOCO8v6ySokzS1E2sxV/b5ysqw2M3W6NIrasjv2K79hkkKySEXZ8oyAX0E5BoE+ruEoHy+xIs7mvy4SSQTVR4IdenZU27JOX/rUUSUCvxCuj92XgFhoZPtVJXcKj7/0mkExCeP9Q7XYFoTvgZsDX+Ob30cjrQcaYtw+QbX26Ghqc2pPR4f1r0JxoDfffUHo/+6dT5aEFgjLRcbA2kA99wGCMOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1k758Oaau62w21jw395tFMtBwEYwj0L/Y7+MjlUAyE=;
 b=j6xfQhPhjdJjzAUWir/mYbc96wUbSwcXpG51HBquU16f15qrc8JRD9PtOc0VANGPKTQ4lNs5bnT3Re7Dhc5Vik8N/RkpAkQVZsl+c9Eq7SJnB2gNBMHfBYmWAc65aEDBlQ9zrFCnyKN6XcIBvHKtKY1qj0xFnz4nZhk56EzzDys=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by PH8PR10MB6528.namprd10.prod.outlook.com (2603:10b6:510:228::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Fri, 5 May
 2023 19:00:01 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::a007:b0c1:5cb:329a%5]) with mapi id 15.20.6363.026; Fri, 5 May 2023
 19:00:01 +0000
Message-ID: <4a174baa-a60d-4d16-683d-80729f0c85af@oracle.com>
Date:   Fri, 5 May 2023 14:59:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 09/14] x86: Secure Launch SMP bringup support
Content-Language: en-US
To:     Simon Horman <horms@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-10-ross.philipson@oracle.com>
 <ZFVC5Fv0wO0Awt0N@kernel.org>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <ZFVC5Fv0wO0Awt0N@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR10CA0008.namprd10.prod.outlook.com
 (2603:10b6:610:4c::18) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|PH8PR10MB6528:EE_
X-MS-Office365-Filtering-Correlation-Id: bb310347-7bee-40d0-fbb9-08db4d9aed96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zRq8wdmhcXF82lWuQ8/FiVXfEyw39xv7aJZeCRdQW4LmsSTqDzkOQ9LdRyDeqU55cAsWOQiVgqgB/uRGnvRv8gATExkhGe9aPFdtcVKcxPS87gZFK3CTQaQVAZ+2L7S1FV3MKo/g9jTLtlL6hKscLBuNqUFhxbTPmAUg7Lg7UMNNwCZNJglK9w+WaFP/eyVG+0DgTeovVONO55aOhWRxBgK0aj2D7AAZJ98Q1I8ES3nSPG3ovH5fEhtCXaeH7OzuiE67gw0V+lHIXqC8yZmO5BWtQ2Vyz3QJS7G19Td5KUU7DcDiVISyl1iiAB4y67todYTHptfxBL1Z2tskIv2wvBleaSW+2KEmfzMOnhgRstZaFBkzGNpTwxbwWW2+dTZdZVBMcjw59sB5K1a9v3dNlu+EeK0/Dq2kKM4VFUEiJ3vd9PcG1KgHrY3bvSMQzZIU8KtBMtbJyeB4NSZRzsEf6DDWBE6lsql8rQ4iURwNkHdJfkueWPg37mpC/304GcDsyYJyAjtQOJSR1PdtxAE+Th2IfENGXcJ5lvBdyZ39pf1yFcTNcXTWkG27llwspnAZC1/C0b0x1t3Tamdj1Lcc9BgDlfM0EvZQr9HthQlkH67QepV3a2gV5JKMq3j+YrU3e0IytXuZDfm2m3nX3T+mzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(136003)(396003)(366004)(39860400002)(451199021)(2906002)(6916009)(8936002)(66556008)(66946007)(8676002)(316002)(4326008)(66476007)(31686004)(41300700001)(478600001)(7416002)(44832011)(6486002)(6666004)(6512007)(5660300002)(53546011)(6506007)(186003)(2616005)(36756003)(86362001)(31696002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVlXZE1BYWZTczMyMlJCS1RZMTcweHV3VkxDV0VjWTFUR0prb3YyNXBCTXlT?=
 =?utf-8?B?QkM3Y0Q2TEdsVDI2bVFqTkV1dG1vOHp6c2pmUWh6c0FmSlVxbStZMkNJZTlz?=
 =?utf-8?B?TnZlS2h2ZUpiK3cvNUhLSWVFRzcyQnRCeTFKMjZXUXdnaW5HMkpNcjgwTGl3?=
 =?utf-8?B?UUNjQmlpbWdwcFhLd0I5VmVydE5hNDg5RDJYSEVIRHJBQ3lBd1Z5czN6Umtw?=
 =?utf-8?B?eWVnbTBwVnBVb0c5WjNDT1hwMENCZ3BHaTdkTE1mQ3NOZEkxVHlqRmdnbHpr?=
 =?utf-8?B?WWNiVnMyUTlHYS9PWFJ5Qmx5RDM1RkI1SExKM1lmQUlwakVNQzdPbXcyUjFz?=
 =?utf-8?B?QnNaMzRFSkhRdHBnZ01yN2Z2NytKME1BdEpNbVBIbWRwckc3Yi9UV1VRZmpx?=
 =?utf-8?B?VWZVZjc0LzBXQXNuendjSk5sdVVVZDZCVklCdDl4STBlSWhVa2dydGRKbnVG?=
 =?utf-8?B?M3VIMk44eDBldDU4MkJ6eFlZT2o2R05KOHgzT2tCdkxaVW1RRWhmRktYR2Y4?=
 =?utf-8?B?angxQThJYXNYZDFZSnJZKzVlVjIzTmxURldyMVh4Vk5pVTB3dEx0b0t5RlFu?=
 =?utf-8?B?SFdPTmQ0R25DUnM5VzBVaTdJKzBXcEE0Y09LNmtUOG9iNjJ4VHJuWURFN2VG?=
 =?utf-8?B?c0o2WEEyL1o5TTFFSzVsL1hWWkw0dVVydnRVYXc0NHBtenFWN3VFMUtSa0hF?=
 =?utf-8?B?M09NUUpvYkpVbjNMTEw0ZVlCUGRZSHJYSERVTG42cXJGUnZwdEZVaThJMi9G?=
 =?utf-8?B?MUptT3VVVjFNcGpqS1pHQ2Z5bjBocDRBNldwTnlxRkVhelFEQWxoaUQxcWZa?=
 =?utf-8?B?RjY0UlRuNG9NN1FDQkdyeWliR2hjTjFPa0VGTFR3K21wdmFPQkg1U3ozbHdU?=
 =?utf-8?B?eHRteEtjUkM5alZaV3A4TG5nazRXK1dVTHgwQUhOUWdPZ2o4SHZxRFVqeTIw?=
 =?utf-8?B?RjNNb3FaQm5oZSt0NnlraHg5Y0ZxeFEwOEFValF3UW83SzIvSGIxeTVHeDAx?=
 =?utf-8?B?c0VKM05zazg2YXQvd3Q3cXYwMDBiOVRsWGlTVG1zREpjdTMxMk5DNnlMN1do?=
 =?utf-8?B?TmRIcFJscUI4enNHRVdSazA4c3ZGdno2Wm9kUnNXSUFSTHI1cDdNNDF0dGht?=
 =?utf-8?B?MFZlNjJDRjlwOW1KaEhyRXByMW1OOW15VUkzSVQ1WUZvSllIbmJ2Y1h1aHdD?=
 =?utf-8?B?OUFaNm9Zc0xYNWlpbVBLcDZ3RWIrdThhSlpPdUtmZzdIbm5qKzA1NTNKb3ll?=
 =?utf-8?B?QTBCckJjeWs0bXNTM2c0UnU1c0o1cjFXbjJDZE45QWFQVEgzdmR3WTRPZUtD?=
 =?utf-8?B?Y2VaeHh5cVdocWE4VXlOS3g0TVZPWWtLS3ZvUkFjNURkTWdWa3lMZmxPczVy?=
 =?utf-8?B?WUU1dnB3MVRJZitDOW5acjNSTUlyRUVpUTRKODJ6SzhNMjE3R21xWlpkRmxX?=
 =?utf-8?B?Mm1tTXNQRnpMdDlKb2JteFpTcUZJbVhwUmdzYjZlQ0lnRzI1WTd1NDVuaW1Y?=
 =?utf-8?B?cnlNcFRRMHhubXhmUW5WUVVBSnI2Q0tGL0dJdTBZSm5KL2trL2lESk41QVZB?=
 =?utf-8?B?ZnQ3YlhTcTE0RnRqSzFON2hIWUxRZE0zeXhOTG12WXRJc3RsdTJtOGJ2L3lT?=
 =?utf-8?B?YWVJUCtMZU00emliSnU0WkV6d1ZvNWZSanN4MkcxVFc2WFJuNHpKcSsvM3Nm?=
 =?utf-8?B?bndHeUVhQ1h4Zjl1Z0s4VzYxdmNYcEVadWoyUXZDb3dKWDIzQm4vUlB3cllw?=
 =?utf-8?B?SDF2ZjYzREZ1UmtjMXNTZTQwV0lkeFJLQ2dXZyt4NkF5OVZ1Uk5PSVQySkZz?=
 =?utf-8?B?NTlhQWlIN3dPdFJpTDZWQWJsT01zMHJvV3BEcktJSGdSU1MvVjhscUVqQ09K?=
 =?utf-8?B?ZU9ZVks2VW1ET0JuLzM2MUIyTldEY0ZFQnVxcFRITmtZQnl4emFTUmtWUlRu?=
 =?utf-8?B?VXR3czR2M3crOXVwVi82SlJHbUhVdFp4enNKQW02N0s2enBaTklyNGVUZHV0?=
 =?utf-8?B?ZWRzYjZxbkpUVXFNYVVSeDJhVzRTc0ZSTnNFMktFaUt5V2hQejNTRVprMlVP?=
 =?utf-8?B?YjBIMmRLMnUxdjJhOHNvYnNKbWFpRHlxVlZBdWxLWW5UQ0xlUFNQS0k0aVZh?=
 =?utf-8?B?cWtxcmV5NUhwZjNSMHFXQjlLeUM2WXlCaWwxOTlGNlpHeXNuOUdidXgwUzEv?=
 =?utf-8?Q?DcQxoSyhWKNySbnCMOF79K4=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?VGExYW9ndElpZVQ1YndpblY5SUt5WUlIR28rUUdjdDJDRit0MTNLQnAvd2l6?=
 =?utf-8?B?bk54YmRraE11Y3F3MWhJdDBaQ3Z6a0hTSlFhUk5sQUlJRHhIQ3pZeExuUmNi?=
 =?utf-8?B?dzE5d0J3cFlQTzk0WUNEOG5WQ29pREZod0FXanNLMmthVEVqMjQ2WnNBYUNE?=
 =?utf-8?B?akk4QktSN1JvdWlEOGVSeDkxZS9ldGo5Z3J6amVWZEVKZm9wU2pDbGdpM2xa?=
 =?utf-8?B?RjFZSzdjd01FekFkZ0lqNGRqdWJMbWg4dG80TkJDWE4vMmRBR3M1UldLWjZF?=
 =?utf-8?B?QmprNlFsU2FhUEZnejBJK1JlcjBUQlpNSE8yWmJWYStlbEM2U2hHTUtnVzcy?=
 =?utf-8?B?SzI5RzhjWXRzUUxaUUI5dXYvQVRtQjl2T0hSRHZJU0xIZThOZGk2bUtLTGNT?=
 =?utf-8?B?U0o1N0U4NTNkVUNiSkkvUU0xTGl2RElkT1BPRUhpME9aTU9welAxWW5wQVpM?=
 =?utf-8?B?ZjZYNjRqN2NpYlpjY1VGUkEyYjRPaXhTeUhDY3NPS1J5eVNZYmNIc25DOUdm?=
 =?utf-8?B?WVV6a0pIQTRzUmFmNkdqVUFGZVREV3k1K3M5VGMzTzNtV2dkd3RLcEZxQUQ1?=
 =?utf-8?B?TmtadkoxZEtQRjE2eVRUcEZwZm9yNFFYYndMT2U4dWYyZk5LRkZQSjdPU3FF?=
 =?utf-8?B?b1EwNkJwSmx4SkpXMkxkOHFFaVdES3lEOUJIV1VBaTYwdTJkNnltOUlFb21a?=
 =?utf-8?B?b2o5MjVROXZzQTM5aTdHcm01TmVHYW1iUlRTR2h3cVB0MDNnbE9WWUFRaWM2?=
 =?utf-8?B?U0xZbnZxY1Q1UHBtNi9rV1FlKzM1ZTdPUkVzT0VCRW93RU15aERrU2hjTCt1?=
 =?utf-8?B?Z3krSjNTMi80OHZRa2QzKzlaUndlWStRUkFEK3hJK296R1NVMGFpdGFBcThP?=
 =?utf-8?B?aVB5TUd4aGtzekdtSXZFdGUwZ3M3bHM1K2VjUU15Y1VqeDlLRkdnQ0JXQmRK?=
 =?utf-8?B?VVNKV2NTMEd6MHRqVGZxN1k0QU02bjdBTmw3b0F0TlJvWGFHOEwxT0tCTVRv?=
 =?utf-8?B?c2RNOGxuUEdjMVZuVkJRK1ZnSDkrLzc2TkV5QWpIUDBjVERyQTVWM2paVjdq?=
 =?utf-8?B?b3krOHh1Y3NUem5qcDkxMmxjOEdjUU9nUkJPeHcySUZ3RGo4QllOaVAzR0Zz?=
 =?utf-8?B?OUYxdUJOOTUxRkYxMytFbTNPc2xuejcrOVFIcHBsOENXSHBqMzUwL1h0SHRr?=
 =?utf-8?B?TVI3cm1KZjVmWlB5ZmRxWG5hbExRcXBNUVBhMjhyb3RveGI2SFdtNnpyVTJV?=
 =?utf-8?B?eU5vVElXWWxuemNwV3dKdWxoUHlJYnN4SGtkbXlJMGM1VEswTnFNZjJWUDc4?=
 =?utf-8?B?QUlsNFZxSERmM3dkRllRaDEySW5XTUdWTzRSUnQyMDNlQnpZRFk2V2V4TXpp?=
 =?utf-8?B?REhYcXhDWEhTSk81b0NiRGh4QnAzZGVQZUZuL2RkSGV3NWpjWUtDbXB3bGFx?=
 =?utf-8?B?ci9pSEtWWmt3VVFpc3dReFFvTzZqdllHemVjdEFMVEdPQU9WN1gvVWJFdUVt?=
 =?utf-8?B?ZFR4akFFaGdYeUk5NW14QTZwQWM5aE5vc0xIVjAzZnVOV2NRVVVGdjgxWGtl?=
 =?utf-8?B?VHBCYkpyZkZBaWhVb2pMK2dMNzJOelE0ZERsYlVSTFRESFFUVlR3a2ZjVXlq?=
 =?utf-8?B?WWJxb3Q5cjVKTDR5ZkZhdExPYVF1Q2R0R293MGVoNmhmd1hlYkJnSTUyU3hq?=
 =?utf-8?B?UFhxczNzTyt0cmxMcWVUUldUdHlMcVFVQXpzZTNYL2xrdFdHOTJ5aEJoLzB0?=
 =?utf-8?Q?M+Mq7NSUI24zbaqqBA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb310347-7bee-40d0-fbb9-08db4d9aed96
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2023 19:00:01.1761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2qQ0691eFgu045IYECMf1xFELjIOucq1vubfdBCI+6BH+k2uAe5NWSRalvwTxQpafRhkseWV5nqUqGAFmSF9iereL+dVNq+YNhbhiZqIEWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6528
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-05_25,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305050156
X-Proofpoint-GUID: G_olDgCwebQXrxYicBUWYgvyP4aIiJGY
X-Proofpoint-ORIG-GUID: G_olDgCwebQXrxYicBUWYgvyP4aIiJGY
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/5/23 13:54, Simon Horman wrote:
> On Thu, May 04, 2023 at 02:50:18PM +0000, Ross Philipson wrote:
>> On Intel, the APs are left in a well documented state after TXT performs
>> the late launch. Specifically they cannot have #INIT asserted on them so
>> a standard startup via INIT/SIPI/SIPI cannot be performed. Instead the
>> early SL stub code parked the APs in a pause/jmp loop waiting for an NMI.
>> The modified SMP boot code is called for the Secure Launch case. The
>> jump address for the RM piggy entry point is fixed up in the jump where
>> the APs are waiting and an NMI IPI is sent to the AP. The AP vectors to
>> the Secure Launch entry point in the RM piggy which mimics what the real
>> mode code would do then jumps to the standard RM piggy protected mode
>> entry point.
>>
>> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> 
> Hi Ross,
> 
> just one minor nit on this one.

Will fix, thanks.
Ross

> 
>>   /*
>>    * NOTE - on most systems this is a PHYSICAL apic ID, but on multiquad
>>    * (ie clustered apic addressing mode), this is a LOGICAL apic ID.
>> @@ -1132,6 +1210,13 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle,
>>   	cpumask_clear_cpu(cpu, cpu_initialized_mask);
>>   	smp_mb();
>>   
>> +	/* With Intel TXT, the AP startup is totally different */
>> +	if ((slaunch_get_flags() & (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) ==
> 
> nit: spaces around '|'
> 
>> +	   (SL_FLAG_ACTIVE|SL_FLAG_ARCH_TXT)) {
>> +		boot_error = slaunch_wakeup_cpu_from_txt(cpu, apicid);
>> +		goto txt_wake;
>> +	}

