Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA926486A0A
	for <lists+linux-efi@lfdr.de>; Thu,  6 Jan 2022 19:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242932AbiAFSj1 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jan 2022 13:39:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44976 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242731AbiAFSj0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jan 2022 13:39:26 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 206HTKGN011035;
        Thu, 6 Jan 2022 18:38:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=8yAyWHEUO1Ynbb2SrGShiDj8/z7DMnFXUppmqH/QMLs=;
 b=E1JoHFm97At/keQM3JoFwMRzCJeO+Jg9DjfJZQEXgqZ3IHhTAZ5Tt7GgNe6nQnouj4cp
 lqkV4L1+kmWgJ1Vkb7DrevfIbfKr/XfqPtJMTZqlYM40Xtu+lJvpbIf17rQBPPTG01EJ
 IoSt5MaE7/Jekuf8WxZYUs0qBOMlQOwDyFMrBwFpydlAQnE87QUq6yinuOAXWstkqW31
 TeQk0cLk1KPdhIunVoFHC/J9oST7w6L/M1krXervsfD+yTr4os/oUI/aSoNgaytSAVQB
 yIVb1zr520ojj7xiLswz7lHr9iATTzChFTq4IGfSZ3v8ORCtQF0Ct+NpIREI/yys4IAa 1Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3de4vb8502-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 18:38:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 206IVpvP059780;
        Thu, 6 Jan 2022 18:38:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 3de4vwcd98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jan 2022 18:38:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+cTeTKeqS8G5fB/gbvQnGjh4UYo6+kV9jdcnODMJU4XLunYCETLUPaczU1ovuje1il8Jpse4LPJjAXJB0dU+Na+hY94IpFQEbEGQQ7NCXg8buYmx/RbAmT64DtxIqMH1LMXvqCsq+Z/Zg5VtJtnfZgTRveVLoaudVe5P+1GxNzcFfwnnJRrizPJYHdZ5ih1kK9OFB+0yNB39UfREza5lCT1c+CDorn/jckXR4kvwId2AHESL+ZJIcEs9GmJlOaAudpZTCwKWrx4TNE5OUOzvtns33Blp2B4LBLco7RcXyfIZEggT8HZjVJx/0CDLsK1aU1vPhvkpcDB3rxwVwwffQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yAyWHEUO1Ynbb2SrGShiDj8/z7DMnFXUppmqH/QMLs=;
 b=IlE4/Yteu6nWXQdgT2K/RE3L1FYIAfXh31LiFYoV9IhGNdGDb3dYKqM9nSdABKwKta1aIEqxrcOaqa6jH1pf8/33EFaRab2clH22pEiZr4lZIRMPQ9OZPyzoraiYkTEkEPy4f5D8yEH9vuwLKHU/C1mBXovKI4QT9RQ58dy+hjJYbBC0mRUeMjK6fwzUYf8zWFuyLfVimViwZRBnT5tfr+0m//NArFj+HFI3jz1IiUdl2xxjtyvorjRnsCzv1uqT/csqoXhqf/CmVaYIwJpjOq1bWdxru9miv4b7Q8HAKDznzuEORxxJSyX2dATzxPtIIZZvIL8phmxavtUXOp8wCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yAyWHEUO1Ynbb2SrGShiDj8/z7DMnFXUppmqH/QMLs=;
 b=OZcbVn6xWmOmvRWVXhHCImvk1E1ILtk6oxfGMBl9wu7jWNd7BD7xKXs5I4gndA5TLFEkpg5xfK6qea+9l/GXkqiPPPZqVHW8L28dpsECl+CKpHpSHWAs/k+PKJw/VxM9eNBibPWLqf/KRQGYpSc+NleI5gx+zPldJ3ehdGrT7tc=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB2990.namprd10.prod.outlook.com (2603:10b6:805:db::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 18:38:46 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4867.010; Thu, 6 Jan 2022
 18:38:46 +0000
Date:   Thu, 6 Jan 2022 12:38:37 -0600
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
Subject: Re: [PATCH v8 22/40] x86/sev: move MSR-based VMGEXITs for CPUID to
 helper
Message-ID: <Ydc3Lbx2O00an/xj@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-23-brijesh.singh@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210154332.11526-23-brijesh.singh@amd.com>
X-ClientProxiedBy: SA0PR11CA0123.namprd11.prod.outlook.com
 (2603:10b6:806:131::8) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7573b924-5b79-4afe-9503-08d9d143c5d9
X-MS-TrafficTypeDiagnostic: SN6PR10MB2990:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB299026492F1E019B6090225BE64C9@SN6PR10MB2990.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v8RgcNBVrwDZs7s8mTcMptNwf9/3gAVBlGh3xeBcsIQBsTc/Da3b9EZMgkFNBV+NUVQQu2VH1jG7SxjprehJ8U9TP3Ii8PtYnDulAyRZmqE7k56/T9xp+A3xFtB+v+RRZL86git8TRocLoQpzGYHCQHOynVesCq1OAQpJCK+VsJ4ksWYFVMorl2GjYLoVqvn6t1xMultJo6seSmxVHocXfx7zpJwtorXbefJof1Rd5aYSrubNeT6i+zXczLxQU5SADGXHLRk2v8naQXqq9k3wSZxeevqZ4jrAdquyU3WO51rnScEUa2WYWJxpQH72uMcUMbZM2qticd91y/sosC3XFPStSS/5DEi8DUSUzAwMyO5cICVUcnB3OTMPsZTQMRB1O0VD4Ru/0OWNEpEnipEyuBnPt9otxZeh/8P+NSNEvNSBQAxggguAXaOjvECZNJI+nGMUjMHZKqp49O1eXhbffgXe8V//NPvEuv0V9eK+9zwI/uLO+GWts78Gk6dRIb4dLe+52olDMkjmrtS0c38HOp6tkqvY978orCKlFhK3w8nsurdu8Tjbfdtkrbc2S5qPCIgtkboxdy/oDTF6VmXwf2mkuNQDa3g6qjxxzvdPiv20h3ccfrnA80U43p1m0VbPKQAjdlsA24EPxYXkjp8Dg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(54906003)(44832011)(66556008)(2906002)(7416002)(7406005)(508600001)(6916009)(83380400001)(66946007)(5660300002)(4001150100001)(8676002)(66476007)(86362001)(26005)(186003)(33716001)(38100700002)(6486002)(9686003)(6512007)(4326008)(316002)(8936002)(6666004)(6506007)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oLMMZC81fuX2DbzVajjuE7Bp/LzZWPWE8uuGiVOoWElLBqTPVKciR8I0uTKe?=
 =?us-ascii?Q?o5Q6JVUlNLxBksaiK3UQRLZY7K/t0ModoAJSpuEQIEPH/6rtmIhaCasa8dqb?=
 =?us-ascii?Q?16l4DMkYSXeLJcbjZH9b90GK/B6GPN77SFBaBHYAFd2zsxgm+mri5vTj0SX1?=
 =?us-ascii?Q?NemF2uXU0VK4pSiGXYKDmWj3fQgiVGs20aqMLtaK2m1nkrtr/cy53qgMhy/0?=
 =?us-ascii?Q?2QNylCy0COyUw9R2yLO1fQh2Sk5mgVbzEY0hsfHz77Lfg7GV7GoQaBSATHxv?=
 =?us-ascii?Q?8y8B50nOQS5ZMrCEu8cuoRHPch8kQ1dh8oz7guN8PK77w9zI4bMDFPbeYF92?=
 =?us-ascii?Q?ZxbRJm+hH/ScT4CIjXKz9L+yro2dpGo0OWlWtR5nGtFn9wZPsDXhPy/RFOTA?=
 =?us-ascii?Q?VQXwI8jNwbPQCkdxRVdPbDca98LDWCTw6tG2RtWaGhoVOFYLTTJnAan7D1w0?=
 =?us-ascii?Q?OKH7LJPzeSLomaLEaVT7s6CmXfRkoQb5LtDJBTrNHLajRMwGxGTE2ppaz6rJ?=
 =?us-ascii?Q?NL35aKb2MNZDe02bM4yOlUBuLKWS5GkB4sf37ohYOAYf2F0mc5tt/Mv9Mgse?=
 =?us-ascii?Q?Qf7MAaez/5H1nBBUcD6P7iKsGLZH7skyW7hX3Uxke6lQLmdJBIiGTEgjSJ01?=
 =?us-ascii?Q?bfUc2JAsBGYNerYYBbRFVK/2q2jj7+mN+IsssrjaWchEILLGLs9CPJ62htjZ?=
 =?us-ascii?Q?R4ihG/b/YGYxpUiF8xxf1WxjFHq83UXWwVLPsfgFcUhBjnkIWqC7AEJcTZL5?=
 =?us-ascii?Q?W9rBVKxEY+Wso1URXXPAQRdkZoqYkB+PWQ9w00euF8vTHbOLGAH5hRyL8RVD?=
 =?us-ascii?Q?o4GO47uHuJWiebNKl0tpmb9JfIRekvWkRL6R1rzfXfx08pnFaTHk8oqUJo3x?=
 =?us-ascii?Q?mo28Yt39pqOleG/PQGeLADUNDiAsuGjS9qOtjdq0fUwrEFtQsQrRNL0WQT/S?=
 =?us-ascii?Q?9BKr0bdVc4GnVNv/XcuUUkL2RE0BBk0d1sCm7c9mtdP8niDEyt3LdkVJDTH8?=
 =?us-ascii?Q?PcKSB5qaRdpacWoLYqXNcZthP5V9r/3spodyL6C26lZTQtXpAw0xLeQ+evEo?=
 =?us-ascii?Q?WzHbZRcdPye9piG2IZOogwcad5urdQmBYeha41aajb1ocaCLJX/JoDGqoAoQ?=
 =?us-ascii?Q?F8gz2AfFcWPOIcxNqWNQGAsa1MgTeZ7J8agIdg1QYPJIejsD+mRbDNskEV1W?=
 =?us-ascii?Q?ClcFjTHMfygXwwud8Wy7fnhmsnLViTgQnK9qUhoS0aKhmFZNsfY76/6jFtFQ?=
 =?us-ascii?Q?eJfLx8XspwiAvo2lLhHsSf9/GtWTReYpIWVNPXxJQ/HwKlC/MkzNzA3dAiNo?=
 =?us-ascii?Q?lcgRU1SI5omfNJF+Svv/PEB03xh99pF04nCW5BIgjW1DBeaqO1KUjea8LSlO?=
 =?us-ascii?Q?h3GC53F3ntoLtVKbP1y68/rAQMXYjf6dVj+oxnPTayZN6ChnfhK9O+CE5UeB?=
 =?us-ascii?Q?0l6fYbPPFoOqUFe/UbPogk/rw+QKpC3/TCsXZfUuUMux56xsJQgWtf9HqOGS?=
 =?us-ascii?Q?i2Y0ZKwKmhMY4tcrIQbBCr/9FAMaqeGJ0r159N9KAaAr/HsQ9nYOyvB0txel?=
 =?us-ascii?Q?ACXZRXNosTLRLuMnsZgBGh5lYyfLSVW/fPXsTE4CDbP8mB/s9/+a/wy8Fih2?=
 =?us-ascii?Q?n/2R647eai75ezamjenXHrRqOiKIKDoZpJt62DcIcRz5lJJookgiwPh+OWff?=
 =?us-ascii?Q?S0QMmQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7573b924-5b79-4afe-9503-08d9d143c5d9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 18:38:46.5119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3cSf65aPNTn6EuOE7/qFnZ+ruogKZmbXDWBceB/KekYi7+btoW+wrODKW2SvIAdcqYhvjgx+DbMOfnyNfKYjvNYUMWPCzxFlCXAJknUqqyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2990
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10219 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201060122
X-Proofpoint-ORIG-GUID: xT3xYxboyzevqXs3lPSGlq3hRvs59l2j
X-Proofpoint-GUID: xT3xYxboyzevqXs3lPSGlq3hRvs59l2j
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-10 09:43:14 -0600, Brijesh Singh wrote:
> From: Michael Roth <michael.roth@amd.com>
> 
> This code will also be used later for SEV-SNP-validated CPUID code in
> some cases, so move it to a common helper.
> 
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kernel/sev-shared.c | 84 +++++++++++++++++++++++++-----------
>  1 file changed, 58 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> index 3aaef1a18ffe..d89481b31022 100644
> --- a/arch/x86/kernel/sev-shared.c
> +++ b/arch/x86/kernel/sev-shared.c
> @@ -194,6 +194,58 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
>  	return verify_exception_info(ghcb, ctxt);
>  }
>  
> +static int sev_cpuid_hv(u32 func, u32 subfunc, u32 *eax, u32 *ebx,
> +			u32 *ecx, u32 *edx)
> +{
> +	u64 val;
> +
> +	if (eax) {
> +		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EAX));
> +		VMGEXIT();
> +		val = sev_es_rd_ghcb_msr();
> +
> +		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> +			return -EIO;
> +
> +		*eax = (val >> 32);
> +	}
> +
> +	if (ebx) {
> +		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EBX));
> +		VMGEXIT();
> +		val = sev_es_rd_ghcb_msr();
> +
> +		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> +			return -EIO;
> +
> +		*ebx = (val >> 32);
> +	}
> +
> +	if (ecx) {
> +		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_ECX));
> +		VMGEXIT();
> +		val = sev_es_rd_ghcb_msr();
> +
> +		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> +			return -EIO;
> +
> +		*ecx = (val >> 32);
> +	}
> +
> +	if (edx) {
> +		sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(func, GHCB_CPUID_REQ_EDX));
> +		VMGEXIT();
> +		val = sev_es_rd_ghcb_msr();
> +
> +		if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> +			return -EIO;
> +
> +		*edx = (val >> 32);
> +	}
> +
> +	return 0;
> +}
> +
>  /*
>   * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
>   * page yet, so it only supports the MSR based communication with the
> @@ -202,39 +254,19 @@ enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb, bool set_ghcb_msr,
>  void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
>  {
>  	unsigned int fn = lower_bits(regs->ax, 32);
> -	unsigned long val;
> +	u32 eax, ebx, ecx, edx;
>  
>  	/* Only CPUID is supported via MSR protocol */
>  	if (exit_code != SVM_EXIT_CPUID)
>  		goto fail;
>  
> -	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
> -	VMGEXIT();
> -	val = sev_es_rd_ghcb_msr();
> -	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> +	if (sev_cpuid_hv(fn, 0, &eax, &ebx, &ecx, &edx))
>  		goto fail;
> -	regs->ax = val >> 32;
>  
> -	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EBX));
> -	VMGEXIT();
> -	val = sev_es_rd_ghcb_msr();
> -	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> -		goto fail;
> -	regs->bx = val >> 32;
> -
> -	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_ECX));
> -	VMGEXIT();
> -	val = sev_es_rd_ghcb_msr();
> -	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> -		goto fail;
> -	regs->cx = val >> 32;
> -
> -	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EDX));
> -	VMGEXIT();
> -	val = sev_es_rd_ghcb_msr();
> -	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
> -		goto fail;
> -	regs->dx = val >> 32;
> +	regs->ax = eax;
> +	regs->bx = ebx;
> +	regs->cx = ecx;
> +	regs->dx = edx;

What is the intent behind declaring e?x as local variables, instead
of passing the addresses of regs->?x to sev_cpuid_hv()? Is it to
prevent touching any of the regs->?x unless there is no error from
sev_cpuid_hv()? If so, wouldn't it be better to hide this logic from
the callers by declaring the local variables in sev_cpuid_hv() itself,
and moving the four "*e?x = (val >> 32);" statements there to the end
of the function (just before last the return)? With that change, the
callers can safely pass the addresses of regs->?x to do_vc_no_ghcb(),
knowing that the values will only be touched if there is no error?

Venu
