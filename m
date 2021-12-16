Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF58E477D61
	for <lists+linux-efi@lfdr.de>; Thu, 16 Dec 2021 21:21:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbhLPUVW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 16 Dec 2021 15:21:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:10874 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234322AbhLPUVV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 16 Dec 2021 15:21:21 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGInLxL016460;
        Thu, 16 Dec 2021 20:20:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2021-07-09;
 bh=sTmIGreCsyjggHenqoaULIPndzh70/rMm7t4BiOhgH8=;
 b=crLKx2A8KxAuqtCxuZYpOuDYdrTmWVv77Nn4/QnDzW/Pkac46LoxesBaGeXzPlZMEJxF
 Qzh3ZuzLY+Asu4TqrmWTnfOF1SCVctdwqP4A2AZMD9Dwo+Uu2EGlRK4I9iOy91Vtz63v
 4rMJ1SujlDKV1ENCCOLoP6tNXAbTln9XFqKDMu4rdOQCjT8hl4P8If1VpIQj1R9GIg3I
 5QsuVOMu5J/fkDUxkHit1fa4+ZMpsfRb+BP9Sv7NYDVfmesdZo+DjT9NymCS5T9EuYL3
 7uwbet7HEC6RJGk4MFaZjzdaGlP5lG3uR/pt/rD8jRrFz3HdxEWXejHHHOigmHfJb4mi MA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykm5c1nt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:20:34 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGKFqDa177981;
        Thu, 16 Dec 2021 20:20:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3020.oracle.com with ESMTP id 3cvneua7ut-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:20:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4NzUxXA5Gvui+IYuA6ugeqS+7/bpo7FWSJgBi1SM/JNRSi6aG+XS6dOXaOTMVCT1eD32a6UQFsAiBetysUUeCyje/MlIO/Vf1bIvbgRHQguQ3/WZ0qtMDz/izUC8S4aqW31I3zEoR2AKn1begrEjM3JJYQsJw7AN0O2d0/iHdAez62RD1WiiCv3b28aBnYODmpuyHRGWnVTGw19O5qqSAYNGCnaSzC5UJFGqvjwzGyWaUMZAdI3NNGM7QozfjWq0Lp+VeCos390ZiYnZj9/KWfhWgIQTLpLzMqPnXF4spFgCiyHb9z26lKFdRDITxgusfYFAS/MJ9N/10+4968ycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTmIGreCsyjggHenqoaULIPndzh70/rMm7t4BiOhgH8=;
 b=lOyFtxS5K0tDRH8MD+KpoCPyeM+T3rfv6oAC95Bkx2/7nw5PHUSggVbJ7D0lHITWWRkNz2cNVEPRoIa5VUlRsa8Wjb7p3jSsXQwXPacbowpI9vQL0ZBmNKgwTuStrKI4ldQHlfreQMCnB8YHoEDo+8dZNqAznY3WzWrxSYXDds6L4qRuWIHqOGPZn5534TRMIdssjpp215Mp7NItdfXChg7gaZui9mEJlMXsq4cm0nNhy5Z9o8SLSu3jdtahTvVJEWi5ApU0R8TKNrzy2tKMdQZd8qJMF5kFbsIXtCPNh5jY3tQq0knaGIc0IofOobZf38C/ZzEAA7Cp24AmJj4KKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTmIGreCsyjggHenqoaULIPndzh70/rMm7t4BiOhgH8=;
 b=iCXsOR5I/UNtydFQlRROxI6CJxdGX+xp+ldhtSzHGft7Xexfjz7MDDjM7/nf4Q6v6NbP0EzMHTTjLFuZGJELEdlCPSis3KvGL3NefBGrC1rr+Zd5fKGJ/XSSU7RQGgTEW4te1q10MZtXJEowedlH9hQuWX2byGyrq0/EAJAOBR0=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SA2PR10MB4683.namprd10.prod.outlook.com (2603:10b6:806:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Thu, 16 Dec
 2021 20:20:31 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4801.015; Thu, 16 Dec 2021
 20:20:30 +0000
Date:   Thu, 16 Dec 2021 14:20:21 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Borislav Petkov <bp@alien8.de>,
        Michael Roth <michael.roth@amd.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 07/40] x86/sev: Add a helper for the PVALIDATE
 instruction
Message-ID: <YbufhatJNvJEl6GK@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-8-brijesh.singh@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211210154332.11526-8-brijesh.singh@amd.com>
X-ClientProxiedBy: SN7PR18CA0003.namprd18.prod.outlook.com
 (2603:10b6:806:f3::23) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdb39ccd-65a3-409e-4f8e-08d9c0d181af
X-MS-TrafficTypeDiagnostic: SA2PR10MB4683:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB4683B42BBF47EFF14413087AE6779@SA2PR10MB4683.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M1YmdUFc1QXypmLv2KS7QBPTqQC4/mt8mENz5GQ5uRM1lUXfjdUOpLbZmwKVsbVk8m/GvxAvnOw5SvtSOb2E2I6glLcpKzhoPEB5LSdLwVuGHjhSjK27kw5zDKWRjyElxg1LoxVprMkMCa7DtkWKVT64s6wgHJQUAY/lE5uAAPT4iRrWkzNVBRBMRXYwz7GkGa5yrNazxDiZf4WiUBuplrx7tVpalJywAOBy1QAXi6U4FsWkfAHVNggmAfqGQdkRLoUoIZHX0Bimx8tCyxHwfrO/0u2g7P9EqNtgLwkGUse6wTsSza9K/g+jJaBZXr9ARueOU/tt5IqJk+bbUhNkkiKiHUeLe8tKDQF9ArHW3kPBBuaz32vwuZgUJte8JDV4z9HlJvM0UBrkQaCViBEs3Mvi9YE3JOvlYgrTzPL8YeOKSV8jDfaIdxSIsRf3PXsGSK6Pr6Q857v+tVLKqcgpmHjwh2Av7J9lFCmWoG+IBoBnKsWJksSK+4ZU+vG5zlPPKVVKo8hU+IrhWFH/Lbu1kzSUqah4vaUv3I6w5aEhnscTpran2CeFtieLPXihW8srWT3zIKQ2OwFDyTSgaj0eep/y+7f4R9xVNb2D636HnjQ3qPlGo+/vlCu/lD5l32QN2+n8D6ApuBWOVTclZbuB+Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(54906003)(53546011)(2906002)(7416002)(6666004)(66476007)(6916009)(5660300002)(7406005)(66946007)(4001150100001)(8676002)(508600001)(8936002)(4744005)(66556008)(26005)(6486002)(33716001)(6506007)(38100700002)(4326008)(86362001)(316002)(6512007)(9686003)(83380400001)(186003)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnVUWWFBMndOend0ajU1WVh0MjJSMFZ5c0pDdFdwek5LazRpdWhJME1hUE85?=
 =?utf-8?B?NDBrY25pMjRTdXRpR2NhYU9EYW5pQmZYSjBlTG1EaUNrQUp3Y1hKODBkd0Rr?=
 =?utf-8?B?bCszUktCL1orRGp6SGU5bm5QTFpab1NoUVhhWkkyL21EMm9XYUdIdTErVWx5?=
 =?utf-8?B?eW1TRjBTVE91OFptbkpIL2RWUDNmOU4zckVlVm9Mcjg1Y3Vtd0p1UForQ2kr?=
 =?utf-8?B?Wk5rWFZ3bmEyd1UrT2F4L3VQem5oSEpLSGc0Q2Q5dXo0MWZZSzlaREFCVjln?=
 =?utf-8?B?U2oxUm9TYXd5VlZ1cTR1NDRmVkxNNzN1QVJON0l4aER5NUtBTitCVkQydzl3?=
 =?utf-8?B?WFFYQ2l2SXdoV0dhdUhOQ2JwdnlHUVpyQjZOdDk2Q1VLUWFMS1UwTzB3ZFAv?=
 =?utf-8?B?UzQxQytOTzZScm1uSDNOSW1JdTZQSW5iVkJ2RktnL21tWi9BRXYxQlQ2NXlY?=
 =?utf-8?B?TU4wYmU1MDVRNU5pcWpnTzRsbENmSWQvcXE1YktseGFzZms0WTV3MWZ5SnND?=
 =?utf-8?B?eld1cHZxYWlGRUZOaC96b1lqVGVnbjNtb2ZwbWtFa01tK0lwTU9jT0lpQWU0?=
 =?utf-8?B?S0x2OTZCbkJHWVVBZDJkU3ZTWmVXSFJKYTJLMlVlVzk4dW5QeVlBMjZGcUYy?=
 =?utf-8?B?eVpTTHVSVjNVSDVLVTdOVTZhTk8wZHVHSm80WFJHd3REOFI4dVlzbjhGZzdL?=
 =?utf-8?B?U0NrZG9ZUzBOTmwwc2tzRzlHNS9Ldk83NjR4SytOWFdtbzVVUzFiYi80RktI?=
 =?utf-8?B?ZzB3U2V2d1FTdVlOZUhCR2xudmprVkRPOHJaNUtDTmlrMFcyNFQvMXA1K05z?=
 =?utf-8?B?Si9zVjRRV0tpcGVlcEJlUXRYUTlSdzZJcCt6REpsL3dnb0lCdVQ2RkxQMUI3?=
 =?utf-8?B?VU1QZkxwUWtsbkV3OHdza0tpVXJYbU1NeGhCZWVSMlBEdjhBY2xTdTZFdHpu?=
 =?utf-8?B?a2hsWWk2Y1JLUFJKdkV4WFJ5OUFzUUlxRkNYN2Ftc2FhYmhSVzMrbGdhWXlS?=
 =?utf-8?B?MnM0MWhyUzFUdmJiQnYwOHNabm5XaURvcXUveUpRbG9PYTRHTXpra1JMT0VX?=
 =?utf-8?B?QnUvcElGSjNhZ2tNSFRFUzZ5QlhmTTNRbFhMajhtZ0hVZzZjSVMrQXJlbkty?=
 =?utf-8?B?bzZmZXRLOWU1a0REbElQTlp1SW1takswayt5T0kzeWFsTXgxYlB1Q05vTUEx?=
 =?utf-8?B?Kys1TEJsVllFS2V0TFRGdnJxaUtPeWxjQ3hwdmxCYlpDRHFtV2lHWHpSK1Zw?=
 =?utf-8?B?bjhUb2NvWDlXYzdpRWg3MzRwQ1RmNlpCRDJHS0pUZDk5RDJjaCtEbGVtdDNw?=
 =?utf-8?B?aGF6ZXEva2VFazFlZ1R1alhLL3ZjNTF2NTFCWUJzb3g4RmxvZHp1R1duMjA4?=
 =?utf-8?B?MmJlbDhPUUN4QkllSzB2ZlZqclZPQlFBcGJ5dXo5aERuQTJvcnpzZ0JuSFBw?=
 =?utf-8?B?QndkczNaQzhSTDFsbFU3dFhRTVpWeDNBbHNpd3RaZVNtblh1WjBGa0ZHVGZt?=
 =?utf-8?B?TUtRcFhvWEdMTG9POTA5clBmNkk3T2ZmUmkvL2h5dVZCMWlnbTZQNGEyc3FV?=
 =?utf-8?B?c0dJRkRnK1VMQzVjam9GRUVNWjBSbi9Bb2pFSEJ1V0gvV2hDSDk4LzhZUzR2?=
 =?utf-8?B?d1B1amNxZThkbWNHWjFhcE96bjkrRjJUMmlOWkVtdGNOSVdHRFh5dGVxVWc5?=
 =?utf-8?B?UjliVEYvVnJMeDRPdGRVa2NHdlE4QXorbUlkZTBtbE1Rd29aelZMRHNEcDNM?=
 =?utf-8?B?aXVFSno5bWtLZ1NaUlA3dzQ5U3ZhNXRFWEVIYWhnVXVMRG9PcEdweEZFOEZL?=
 =?utf-8?B?SzM3Smo1aU5JaTY1S0lHWkR1MFc1eFU2K2R3eHBzZkYrVzdSUUhyVTQ2eDdN?=
 =?utf-8?B?ZG9EVk92UHlKeWpYNnpha1pPNm9PK2U3cnJ3ckVQNnY2VDlWQ2UxVmd0Znhi?=
 =?utf-8?B?TzJtbzNrWWVybDNuRFhpMG16aEVLbzFVNzdoRFVaY3NVVm1XT05PanNYZHVk?=
 =?utf-8?B?VmdXNWp0Qjh6aU83MGY2MnRDdHNtOTdCY1FpL3c4cmFmQmx2a0NDYmpxcVI1?=
 =?utf-8?B?MGxwbXBEQVpoMVJVQVpnY1AzVzZqL1E0S2plWWRGZGp5MXFQR0EwdzBrUXRh?=
 =?utf-8?B?T3FFQWNwS0VuUzZJd3p6d3RnR0REWFkxRkNtQWs0TWhQb1lOZTVHRHJkeUNT?=
 =?utf-8?B?MmlPck9kM2RVZmloU2FHMG1qcHNlZ2VGb2VMNTJuay9NY2tjVWJ4NXpPMHZi?=
 =?utf-8?B?OUdoR0VCKzFOT25BY0NHVGJsWUl3PT0=?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb39ccd-65a3-409e-4f8e-08d9c0d181af
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 20:20:30.8352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0SwVn03P/wtH2bAaEb9U0p8Z4+9zXAzMqrZ4WfZWyPuO1XiskVq8m9m4FNugClfdyh2r7TlM+F1UWRJq3zVqXM1Yop3M9BJhwRbUGfTNwBE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4683
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 bulkscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160110
X-Proofpoint-GUID: Ktq0AqsY_HjRvqisu8n0DTqByEKo6hyy
X-Proofpoint-ORIG-GUID: Ktq0AqsY_HjRvqisu8n0DTqByEKo6hyy
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:42:59 -0600, Brijesh Singh wrote:
> An SNP-active guest uses the PVALIDATE instruction to validate or
> rescind the validation of a guest page’s RMP entry. Upon completion,
> a return code is stored in EAX and rFLAGS bits are set based on the
> return code. If the instruction completed successfully, the CF
> indicates if the content of the RMP were changed or not.
> 
> See AMD APM Volume 3 for additional details.
> 
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>

Reviewed-by: Venu Busireddy <venu.busireddy@oracle.com>

