Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A83B700CC5
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 18:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjELQS0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 12:18:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjELQSX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 12:18:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBC793CF;
        Fri, 12 May 2023 09:18:22 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34CF4BbQ002651;
        Fri, 12 May 2023 16:18:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1jcxMbefV/irQd2wf60wkRBTpJuPl1uwGTPQ5ooK/Js=;
 b=Fum5r4WIYAt0gVrKjSILmIlBIOpM7TrTZvzfWRonKczDLjck6OD495migplBzt1NRxpy
 SvwfL+/Qa/dxl2KxSoLueGcRIsneGTd4OcN0+NFFWifAxp4dqrH266vOOLuR5Y0z8/No
 xXdHkOP80Cm+wOe3H83WC2ORVOv7djMm7j19zZJgK+LnF7J+GcJ7P+9aavIbhYRjm4Lz
 FUqyH3ODIvijUOdBXKpKMBB0jVRh6FP5PSawm6KKMFIAjafBYULw5Ol9dmslthmwuVVO
 T8ssvmsxadXo4PJXySmKLOjCA0TujqYuusMcO69ky9N3KVhEs0gKH48gxWh5DhxnUDg0 JQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf777b3qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 16:18:01 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34CExgse004427;
        Fri, 12 May 2023 16:18:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qf7pnngnu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 May 2023 16:18:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NxPGIfCUgLUS+L03MpUJYZwHl4eZWSJlmq5NFlMWjeefR6lSxWW2M8x3QzU0+O04585fMt4Zj7SWnKUaT+e6zVpwv67anzWNjsBg/M+wgxUg3IqB5+XMyTU74oOv8d/K6XMxn2DfunuQJxsvoRe8tIUjy/m3wR+lGOzbkSh8l3nsfAMRdshujZFMXOWA4FnvzBRgaW/gfbpeAVKgZDljHrFqspdctjbpf+fRmYZgxQcGnmpgpnvLE6zqH3fdrJFWhgd7cAvFEUlyNtgE7VZsPVyKi9fhoPw2Lm+vw2ots1Xopmau18gPcgFh//AzZbAdzBh6d6IR9QJKtLVK1X0ixQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jcxMbefV/irQd2wf60wkRBTpJuPl1uwGTPQ5ooK/Js=;
 b=OhhoTol0rDeS7/cdk23DoYwi1E97mcN0ByvFdixEMA7I/w3zUT6GceLrS6q9vXPlnm2kXPGbskaZhyB2fid8kRUyPtEiyObCu6/uWlKqkaUTdKFlcBJVOxzOoR4LXg3QUd/92Yd/BLLP1wBuftqTVA+T0YHTSxlONZogHWM7+lIhw54HfVyej/f77TXLiVgbQq6KxKXaUsAUURLZkM1ZvQaQ7bx/bvyhH9jUcHHD4junCanMkYdEb2/0HBlgrRznwxSqwZxRjSFRCRnbSS1bNB0H+/JKQ/hlgjIqI3KcJtGUoNshdKwxcPMGE1RupYydtuVRweHjXlgBYMaU8wD2+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jcxMbefV/irQd2wf60wkRBTpJuPl1uwGTPQ5ooK/Js=;
 b=RIM1LxUbWeNH3018UrHl6TH3FEvQ32MLNTcvYbJjNx6g6J8RN/mCYJ36XNUjz0RChVp2t/44kCvabHvq9ykLl3nuHernk7OT+gZ0bw3nj6b3VhIF29tpondwGrZw+780zZ7d7GcpGU7xK4+hz5oNYlTw/Ox26nyeltxFMw2l4rw=
Received: from BY5PR10MB3793.namprd10.prod.outlook.com (2603:10b6:a03:1f6::14)
 by DM6PR10MB4155.namprd10.prod.outlook.com (2603:10b6:5:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18; Fri, 12 May
 2023 16:17:56 +0000
Received: from BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91]) by BY5PR10MB3793.namprd10.prod.outlook.com
 ([fe80::37d1:ec08:a280:1d91%4]) with mapi id 15.20.6387.024; Fri, 12 May 2023
 16:17:56 +0000
Message-ID: <98decbe9-846a-6d36-aa7a-f906a19fa6cf@oracle.com>
Date:   Fri, 12 May 2023 12:17:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v6 07/14] x86: Secure Launch kernel early boot stub
Content-Language: en-US
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com,
        Ross Philipson <ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-8-ross.philipson@oracle.com>
 <20230512112623.GE14461@srcf.ucam.org>
From:   Ross Philipson <ross.philipson@oracle.com>
In-Reply-To: <20230512112623.GE14461@srcf.ucam.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0304.namprd03.prod.outlook.com
 (2603:10b6:408:112::9) To BY5PR10MB3793.namprd10.prod.outlook.com
 (2603:10b6:a03:1f6::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB3793:EE_|DM6PR10MB4155:EE_
X-MS-Office365-Filtering-Correlation-Id: b9f5c3fd-0270-4c58-93bc-08db5304718e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1fX0l7ro/vyRaTajr+l34PA0gTgGBo63Zvu/DsSmXh57s9qtJn2z7kPCN698aFXBE5j8o7tjNsTUtc/rg7aHeMdYPOX2SktUivk1OJK31iqMMp8vjWknoCbG1UvAZUYn3mqiOebGbAIgDTk1BVuB3sjJJDANddjqH/LrB5ZQYPRwr5wIZUJ9izq98u6XGBL9DEEH4V+NM5/cHwwuliM8KXfUoZIVZIga60HSzguBtenIs3ScG364fRKQC4IEhZKFCtP8tRu2lhCJ4hkBhGgyvKEMXmfVPGBIaJ25AcBzxa3xn2BRcflyqXHv6aTh0i6s1Y6+kyhRSDZiS5JrySesK0DMNtUkqt34t/j02RK4QXbMAgQSWsRHHOTe1vJciP0BbbVJ7qkgpB92RXMdTLOaOT068jBT5EqKbHz6XLLqqIjUMi6nJSW9Bq0fYTrxn/Xw8s1bAqeaONrakDKWK6OaWD84EjSF2/S5X3mKRfryGGv8Tvev9dqs1uD0Gm734zGuNUeneuVjzWvfTd0DR/PGKZOfciyruTE6yb178KgKt/U7YTX0xNChNKhqSOvsSuShfS/PHVVusgcVbrSAh1m9U7V+eompWdvDyJXRQXUuhxf2vZ/iForb1spchQOw45VmMdOCvAJ3FoVMtB49u6A+8w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB3793.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(39860400002)(136003)(366004)(376002)(451199021)(6666004)(7416002)(478600001)(2906002)(186003)(2616005)(36756003)(6486002)(44832011)(316002)(41300700001)(6512007)(53546011)(6506007)(31686004)(107886003)(83380400001)(38100700002)(6916009)(4326008)(66946007)(66556008)(86362001)(8936002)(5660300002)(8676002)(31696002)(66476007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b3NKR2lQQ0EzK0ZCY3UxT1NaZE1wMlpwTFFQZ2Rya2J0ODQxTXJCdHVaZWtY?=
 =?utf-8?B?TElCRnd6ckhQUHpuckxmSTVoY1JUVE5XVENqUGxmYldVd0xuQ2cwSlpXWnRJ?=
 =?utf-8?B?blMrTWlnbnhGL2NFRXFtSWxROHFVNmx5ZTJ5R3d2TzNFaUdUUDZvaTJsbGs5?=
 =?utf-8?B?dWFQaEFPN2wyMUticjdSNFY2Y0RMSGJSdEVTeTlKRi9Kc2ZHZkFKV1NoaE1v?=
 =?utf-8?B?Zi9WVVhXbTlKWXBOc1p2WGhGc2U0YzhWdVBLSmJlWnU3QVpSMGhUQWtHeGp2?=
 =?utf-8?B?VEYvSFpoTUk0aDJCSG1DbGFrZjVVOWpidnVOZ3I4UmVpSVpneDlnNjhsSWs4?=
 =?utf-8?B?cWpwbUgvdmcvcHRlN0p5dWgydWZBUmNRWG4vMmd0Wk5QTzd6bk9LR2RTVFVs?=
 =?utf-8?B?U0FXL2QwUElEMk5EMFhPR2xJOUFwWWprTTQ2OVRvRnlYcS9ZaUhKWklsZnZQ?=
 =?utf-8?B?VHB3VkV2eHdVRUdLQmhkUExVUnh2QXdCRHdHaEtNMDlrMGZtS1dVdnZ4bnlL?=
 =?utf-8?B?a0N4a1pWZjY5Y0lzOWtqMjQ2UHRTSFB3KzkxS2FkSG0rRGpNbCttbTdsNzZl?=
 =?utf-8?B?Yi8rbWpuSTkwN01ocFg5YWNTenVLbEx0bVhMVmtmTm11c3c0VUlXdmhCN3lp?=
 =?utf-8?B?a1h0SnJJY25vMElab1l1ZkkzbXdJa2VDUmc5aWlzTUI4dFhSTndnTFR5OXRa?=
 =?utf-8?B?dFVPZ2Nac05lNENUOXFBT3Nsams0eG9QRkZIaEMrZDMvWWJFMHRPY2hIOGxU?=
 =?utf-8?B?K01GelE4Q2JlOGM1NHlvMktueDdBRzZTVy9qRXArV0FLeU9RQ1J1eldVdzBZ?=
 =?utf-8?B?OUhRaDEzejVYSzE3QlF4Mmx6eXg3Wjl5VnIreDUyaGw4T3diMFdHV1VVRDB0?=
 =?utf-8?B?OUc4MHlLVUZtdkdZWCsyVWdlMCtLRzAxekQzYXNJQVBPVEtZOXpzY05Ic1da?=
 =?utf-8?B?M3VZbjJaK0ZHMG5vK3pJbXB4dkVXSklBcnZHV2c3TGVrVC9mNlhaSVprS25l?=
 =?utf-8?B?NUlTeUJvSzU0T2JIWXpDQzlGR0JZUHo1RHljejJjTTVsTWs2VEcwRWh6cXdv?=
 =?utf-8?B?RWZIQnFTcGY2TGt5QUhCK1dDa1E0YmdMNGF5aER0TTlKdUNORldIL21kTm00?=
 =?utf-8?B?RzhLRS9BVWEyN1BNS3F5OWRreUJrZkN0V3REVnEvd1FwcTAzeTlEVmc3dmZy?=
 =?utf-8?B?UGhHWk44N1ZPNjFDK05GQkVIM2YvNk53bkk5NTNEaC9zbnVVK3NIdTNBbFpp?=
 =?utf-8?B?VEFJYUFDMGFSdUZtSXdpQjVnd05neWlhOElpV2xWaEQ1NkdxMlJLV1FHR1l2?=
 =?utf-8?B?elFiQnhUenBIK0xsZ3paWi8rUHdYelFzV2k5ZE1EbElPOThoSnJiKytocHRu?=
 =?utf-8?B?MG0wNVFqQmFXWkZ3b2dpRHhhRmdCNDE4cUl6Y3NIOVB4eCtnd3ZrVFRGWk5H?=
 =?utf-8?B?VGQ2TzJtc1JvbEtXcVJucmhYTUlVOTRXWFZyTGYxSEppVm9XWUQra3F1ZXdv?=
 =?utf-8?B?bWdaTGIxcC8rZEZLRXZHblpYSlAxdXcwWmFRWTIzTWNERWRHNFFGcTczMkxR?=
 =?utf-8?B?N3pSaEZqQUtROExDQ2RCdkdmNEFyTFZVVzN1L3RKV09sYURXclRXWkdqbTNl?=
 =?utf-8?B?ZG8rVDFTNjJOV2lFY3VZSnl0MlVsV2JUYmhFcWRHM2svb05YS1RkNkRUTWZE?=
 =?utf-8?B?RkNFWTU2cW1tYmx6aHM4Uno3ck00QVZZSkV1MWZKQ21VVjNJWUlldGlnWDlV?=
 =?utf-8?B?b1JTdWtWcFIrUDkvN0FMbEE0ZmEwZTRsb3ZqaWJjVTlCdis0Z0JOY3hqWEds?=
 =?utf-8?B?bDB1R3l2RW1Vd2dmNitSR1FyRDlYYmhQcHNzaDFYcDIzUjdsZ0MyZnNJcVN4?=
 =?utf-8?B?YWE2RytLZUVZRTE5WW16cCtHc1B2aEpRSitKQW0raXphaVFPYXA5SzA4OVBE?=
 =?utf-8?B?dVJjM2RVNXRGSnUvNlJRY3N1R3BZUDEwN0Fqb3NmL09qano2Y2Qwd2xlcC9v?=
 =?utf-8?B?UVoybVl1cEtTV3YxaGZSNGRjQmRVUEhNYWxabW1TYUpERk9IcVRLck4vWXU2?=
 =?utf-8?B?UzVmeWtUanErZ0J1NThNVlRDa25yanE0OGhkZS9xK3llS3RDTVJUNFM1YWpL?=
 =?utf-8?B?dmpWbW93SEFHWStpWkFzalRmNGtFRnA5OURicmRLTis1eDFVZlh3VXlEV0Z3?=
 =?utf-8?Q?TKBYMY59f05meoAxZie6Esw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?REJHeER2S2R0cnJxQnk0NUFYQVowTFlQSnJwb2RkaEpMaUdyQ054dHNDeG9n?=
 =?utf-8?B?QWxUajZFZVpQK3FFWEM3MkJLRzFDbzdkaUptMmNTZVBFVmJwYVBPeUdGcnIz?=
 =?utf-8?B?R09zUm5UL2o1NmNWdDNYMGRQRTRUTW5ERHF6WE1Kdm9hbFhCRkVHUktCSGFt?=
 =?utf-8?B?c2tTZktBdThKQjROOFpwVkxzMTN1SzhORXZWSnUwRjM1MzVQTWhBMERkaW5G?=
 =?utf-8?B?MCtsZXMvQ0pHa3VPajJjdUxsV05nZEo2OHh2UmExR2JIY1AzMFZ4bXlRQ2Zt?=
 =?utf-8?B?Qk1nYWJtVVhCd3VkeDFnSlJJWGI3RmRGczFBWC9YK0xoQ2lBRkdZdmFmMlE4?=
 =?utf-8?B?a1IzN0lKWGpEL2ZLSHUzeVlZSHBIS0ViSFhjdHFxaFRaMkdZdUh2UWNyOElT?=
 =?utf-8?B?elBRTXB4bFljYmQ5WThYOTZSYUlkVmV3ZE1rWm5XUHNab0N2RWx0RUZHKzRX?=
 =?utf-8?B?UFgzRzc0SUd1Q0J5S1VLcWU3RE41VllyRDU3VXZCTTFJYXZINE15eEh5a1g1?=
 =?utf-8?B?L0MvSEcyMzJINjVkTVlSRlo0THdmUEtMTnE2TzNMLzlWTmk1RW5oR0QvdTJ3?=
 =?utf-8?B?OHp4UVN6WHB1YUxGOFdBSURIcFBLMGNsQkJwTE5Ma0VqS1VhS3puWFluT1hp?=
 =?utf-8?B?Ky9ubzRrMjYrajk3SU9jU0FqQnFxUE16ZUxhTG5LT3lCeW9KNUR5Q0xHZjNE?=
 =?utf-8?B?YWhpcy9CWVpFVm1XM3RWVis5bWVDV3BwcklENE1ZYVBqcmY5L24zY2xtSEtu?=
 =?utf-8?B?SFlFNGxISVR4UG5NQTNOQWU3NkFNSFVOQjR5OGJUdEVISzR1UWRUQnovcHJM?=
 =?utf-8?B?SHJhM0JDQmtYOERPWmJKR050YjQxQzBMNHA2em00WUxQRm92M3ZDclloT09z?=
 =?utf-8?B?MTgwWkJnVTYvQ3Q4WkRwd215SlNVdHhzSHFDVytvUTNCYUs3QkpWcWQ3bDdo?=
 =?utf-8?B?Z3lIekt0dE9aeU1wZXhhVnBiOVVLWnBBSWRZQWdwMEVSSUVZWUtSMEc0MDVy?=
 =?utf-8?B?VFJXNUtSc1Z5cGtjQlZNWGZsNXNqU0JkajNhb3Y3a2RBb2VDek5ZSjhXVXY4?=
 =?utf-8?B?Z0Vrd281UHo5dmt3UGNuakx0WkhIclphR05wM3BLb2xja0c2c0t3NmwrZ0Nz?=
 =?utf-8?B?QkNtVnF0OTlEZHdzRTNaTzVnc2pKclZLSTlHSkU1a1BFWmlNQWI0UnVBVUVt?=
 =?utf-8?B?YVM1MU05TFZkMnJTQXA4RnhYY0o0S1FYQ0NwczdHLy9oMEJQRzRSOERaUGQ4?=
 =?utf-8?B?T0x3MUVzZFFHdW41OEFRWXlLdG5xZWNjNUJEZ0tKWWRyME8ybGFnenRIOElu?=
 =?utf-8?B?L2lhbDRuczlrVjU5Q1FzaTY1dExHbWJXbGdiOC9TNE05emZPTC90cnZIZlht?=
 =?utf-8?B?NTRwQzNMYzhlanlwTEVUNnI2NVBlQVpReVhaTUxPUTYrVTdnejVXZjZyMCtL?=
 =?utf-8?B?RzVSdlJWYlRzcFdNNHhuQnJVaFdITXNvS0dqRktMRFhZYmVlMTRqUXNHbUlM?=
 =?utf-8?B?S0w4Mi9aY3dRUThKSkFTMEZ4Wkp2YjRSd2tRMXJCMjd3djJTQVMrWnRUcWhW?=
 =?utf-8?B?SDFuaGs1dXhUVVJSaEpMc2ZwTkR0dGFQZjR5T1BXZnM3Z24ycUptR2hDU2Jq?=
 =?utf-8?B?R2FzbXE1SmlTbktZYmZpd2FpVVkzb3l0d3ovY2k4azZSRkVuWDVtRWRmYUJ5?=
 =?utf-8?B?TlByUkg5cHpYTjZRUnJSNHl0SWNQc2MvVGs0Q3Y3aXlRN0NMMWtjVElOa1RS?=
 =?utf-8?Q?5CMYJU40Ki9IhUJR6Q=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9f5c3fd-0270-4c58-93bc-08db5304718e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB3793.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 16:17:55.9450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFWYGOQ3s4bXKNAdLdeuuD8HUFNBW/CKxqyYWp9YUNezbgHe24Y+dIHSBDOSepA3Wj2pZLpCuqmmwDxnoquKtjwdYUthhsLpkM0gfY9Y6pQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-12_10,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305120135
X-Proofpoint-GUID: 2XWCyfNVzTJ6rB9cUXe9G5yqoUM0ZSaK
X-Proofpoint-ORIG-GUID: 2XWCyfNVzTJ6rB9cUXe9G5yqoUM0ZSaK
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 5/12/23 07:26, Matthew Garrett wrote:
> On Thu, May 04, 2023 at 02:50:16PM +0000, Ross Philipson wrote:
> 
>> +static void sl_find_event_log(struct slr_table *slrt)
> 
> If this is called after the EFI stub then we're presumably
> post-ExitBootServices and we're copied the TPM event log into a
> configuration table so it's available to the runtime kernel. That also
> means that we should be adding all further measurements to the Final
> Events Table rather than the initial event log. How's that handled here,
> both in terms of ensuring further events (generated by firmware or by
> us) get added to the right place, and in terms of ensuring the event
> logs the kernel has later on were covered appropriately? Or is the SL
> event log an entirely different thing that can be merged in later
> because it only covers the DRTM PCRs?

This is a good point. At this point it is really something we 
overlooked. We will have to revisit this and figure out the best way to 
find the final event log depending on how things booted.

> 
>> +static void sl_extend_setup_data(struct slr_policy_entry *entry)
>> +{
>> +	struct setup_data *data;
>> +
>> +	/*
>> +	 * Measuring the boot params measured the fixed e820 memory map.
>> +	 * Measure any setup_data entries including e820 extended entries.
>> +	 */
>> +	data = (struct setup_data *)(unsigned long)entry->entity;
>> +	while (data)
>> +		data = sl_handle_setup_data(data, entry);
>> +}
> 
> Is e820 sufficient here? There are cases where we use the EFI memory map
> directly (sorry), but I don't know if any of them are relevant to DRTM
> outcomes.

I am not 100% sure what you are asking but we also measure the EFI 
memory map. This comment is just to note that if the e820 exceeded the 
space in the fixed map in boot parameters, we would pick up any extra 
entries when measuring the setup_data list.

Thanks
Ross
