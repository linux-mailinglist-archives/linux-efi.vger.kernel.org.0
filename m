Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9883476240
	for <lists+linux-efi@lfdr.de>; Wed, 15 Dec 2021 20:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233716AbhLOTzF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 15 Dec 2021 14:55:05 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48762 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233701AbhLOTzE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 15 Dec 2021 14:55:04 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BFIGR2f018858;
        Wed, 15 Dec 2021 19:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=QzGZVMyYyH+J46B8QDf8Z62c1sWxF63QBf7coKkstVg=;
 b=lnS851OJNDCZx9ZwQBh6SLqNlCyM6rMicpgd0yP1JfE68KPJ54sGpGhr7VvY9WxVGYT8
 8oxxbvkQLK6OGnZgkh0zTakP8GjBVQM41oZMCF53f/V/LGkJozsk6k0dXXZQKJCAemAA
 TYpdUmmvK1SywEOwWucUewYlKTiNsCMvRL4az+bH9+eJ6H0T7f8Io6zjMLY5uX0dupSj
 FkNJZeByKhLFy60Yo1uahsw1U+jlMc2N0P4dlC3bSY4YwL37kDR1lpbZIior4I62R+cM
 psPyG2/3t6zSuQy95ScgRoOUTkQ3AFxe/U07VGHmKoPH9miTadXzMxNRmPz69rk/BHbi +w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknrgnu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 19:54:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BFJk91n079859;
        Wed, 15 Dec 2021 19:54:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2168.outbound.protection.outlook.com [104.47.73.168])
        by aserp3030.oracle.com with ESMTP id 3cyju8u4be-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Dec 2021 19:54:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRjuDtJHcoysvPNx0S4Q4RayNRPfEHMCDI0UnqV2oi7cn9k7A9qVwdeFZ9AUxbydc4vWiO/QK/i2i3wUt59yIqkK9ZWNx6QzLIK28LWnPhU8huB1eUv/0Y5m7Mui9q3ahTgvIMHdZDP37t1UqzltQU9XWsU0BVfRynyIovIIrEzLWntibo5qW9G9z9hc+2r0fg1sAB6sbqsh6T+a2+YRgrCDlMiz+mIs7tYv/EgzAJWuTbOQMAy4hvrpA2fsuNfXVinUanNrbtGykG3IXRSJBKzrXMWeyC/dHnOzugbNyO43Z5ZQAY5EGS2Yu92d6+0JOIELMBsIzx7Ko3eVV/j56Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QzGZVMyYyH+J46B8QDf8Z62c1sWxF63QBf7coKkstVg=;
 b=daiJMjGEHUoTaAsGm07DFQQGaTJ178v3xd/bx0OCEAJnZSepH0ey4PhFUanien9qTSa+6PVXhJgwLkgZUPRGKCezxUcWY/zwc/G1llhhzoMHB9PhfxnTHv3C6MiWpgrwWnaNRdTZGs1rYvmDCoPSHy+7NfEN4vH8ejd2Rhyad/yIEo7anp8trW5BjoC4XXMiR7oHtf/SvP9EhKSHVhm1t6WdUQeki9jaP1KpoPL+fZigXoq0jBfG4acpX2CM9yWWYw9bkwEPuv+ksnYcdR5UxMzZ8aWwLbVe54xs0TxOqTTNHgImBMENfTEz5vhtIS0dDeGa31DG21ZhpBjci1mUhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QzGZVMyYyH+J46B8QDf8Z62c1sWxF63QBf7coKkstVg=;
 b=C/R3up1rL+2Lzsq9j93Ahgd/0BjGmxfOT0HVQt2yPDXnbIpEunKglMIbFCfZBQ6RtqrMrwDET3KSkrfzqyDjAGWVb00/xxWQOM6R4F/B6+dN1zZuhG31V6qQWkfRP4vyJm0ImnjfLMiFykxawZCtKIrC0yFYYlRk996Q0MJkSEU=
Received: from SN6PR10MB2576.namprd10.prod.outlook.com (2603:10b6:805:44::15)
 by SN6PR10MB3023.namprd10.prod.outlook.com (2603:10b6:805:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.14; Wed, 15 Dec
 2021 19:54:25 +0000
Received: from SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412]) by SN6PR10MB2576.namprd10.prod.outlook.com
 ([fe80::4c8c:47df:f81e:f412%5]) with mapi id 15.20.4801.014; Wed, 15 Dec 2021
 19:54:25 +0000
Date:   Wed, 15 Dec 2021 13:54:15 -0600
From:   Venu Busireddy <venu.busireddy@oracle.com>
To:     Michael Roth <michael.roth@amd.com>
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
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
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH v8 01/40] x86/compressed/64: detect/setup SEV/SME
 features earlier in boot
Message-ID: <YbpH54ZXToI8kRQ/@dt>
References: <20211210154332.11526-1-brijesh.singh@amd.com>
 <20211210154332.11526-2-brijesh.singh@amd.com>
 <YbeaX+FViak2mgHO@dt>
 <YbecS4Py2hAPBrTD@zn.tnic>
 <YbjYZtXlbRdUznUO@dt>
 <YbjsGHSUUwomjbpc@zn.tnic>
 <YbkzaiC31/DzO5Da@dt>
 <b18655e3-3922-2b5d-0c35-1dcfef568e4d@amd.com>
 <20211215174934.tgn3c7c4s3toelbq@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215174934.tgn3c7c4s3toelbq@amd.com>
X-ClientProxiedBy: SA9PR13CA0156.namprd13.prod.outlook.com
 (2603:10b6:806:28::11) To SN6PR10MB2576.namprd10.prod.outlook.com
 (2603:10b6:805:44::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e0d5d6b-8c69-4bc6-709e-08d9c004b200
X-MS-TrafficTypeDiagnostic: SN6PR10MB3023:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3023B740A676BD565BF71CD1E6769@SN6PR10MB3023.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GtEdHxA27a5ifK3Lnd8v+9PfjHtjyQk1n6aJ0XqeuDzcB4C28+qsKW50izL909tbw6s+PgKissJCOVb6NjSAAaJIohL5ALjkqzhdInee9fGdDXm+QezSwMrtB3ukHolCVR9OwFKFlFeU5d7stdZPxPhpsxrKHgMdw7AS5vEiq7CD5m4VXFxPag6OYQz8acnUtoRMVyhVEYTpNeu9NCYVkpB+ySTYWFZUVckcmRZzJ4sUmkAo3soi5fpdiObtgqpRqLhCaZRwujx4CR33HDnDpilJarMD265ulZiaJHFFi5FnDtHQpDDuFdBkdYijgaPN9Yx+G7ILsipxmmxwCTfBSQKMdzQswEGXW8mape1V5lNrmzlJrqBeLfL1Ut+MsWtEI68IEkaZBQsADz2OTRnnFmxpsR+WfhzQ2h7akCoNh85at/vxE7KyGRvl04XG8x57fZWkSHrxxFgblNjcasGQhTy55EXnxzu3qJIotaFNmsNn5JBa1H695HFPasFHiHMjIYkGpZLntjIuu8g0idPqp3ntrjVncOXZ4mzR5bX+90ZkMWht235dUrkiOhh82WlsDh/yk0Ng0sMlSYoL0H83/ApK2taXRB2YNOP0w2owmZ69B7CGih/tJu0smLHn1id94tG2osOoLc7Jc4c6Hbf/Ag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB2576.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(186003)(54906003)(4001150100001)(26005)(33716001)(2906002)(6916009)(66476007)(7406005)(6486002)(6512007)(5660300002)(9686003)(53546011)(44832011)(8936002)(8676002)(7416002)(6506007)(316002)(4326008)(508600001)(66556008)(6666004)(66946007)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ycqqVNudNMeT5TcCtVdCcpZT9yLBkscLnoHw6jvKwfo3n14KZp+QphRQOGoe?=
 =?us-ascii?Q?s6UsukVUAR64xhSvTld42rMcvMUTUdKbfRI4W4gcMRai+m/tB+BcZkaYddF9?=
 =?us-ascii?Q?SOG/t6VcESC3DsjRmA7TlzSjrW6S7nnRfPVWNkuAzejEKEzgxqbLyZLcDwOT?=
 =?us-ascii?Q?0YPPA48nAM/P+nC+cYZ6g6rEV3JERkGgXaY3SYzOg8+p5bFuADUeRRfahRh4?=
 =?us-ascii?Q?ZfadJRNTgPTuIpbf/IbsIrD1ndI/76QbZO1gox+oBuOIrtgF+ZpU/YjX71kG?=
 =?us-ascii?Q?+iem0h15V5Ig+rWt1ipDJIUqdnjpuwv+7L/nQirl4pgtsYJMhtAfY8MVnI2F?=
 =?us-ascii?Q?Y76JK4B5IbDTRufDuq8IQmk1FylYqYRa8AoImdm3tcFwkO6xTI3cCLrEKmap?=
 =?us-ascii?Q?hE+ZEj5L5k6RNmfGKiQQHTBDDh4T7q2U7PswGv09mLPpd37/RL4ueu3bE+V5?=
 =?us-ascii?Q?kbHnUuApEsvTExSSNQzSKKvATqHrW6lcjlPkgy3xv1OTSW2iB9+b4RnWpAOb?=
 =?us-ascii?Q?0BNdbFlZYRCEqrYp/KBm5guUavCBdTJM1NErNJoUX1MCArDJWM91sDaCVZny?=
 =?us-ascii?Q?1sA0IWfgiMJcIbfOvdnGy0iaIS3l/CT+p6UZ1bCOX4HvltkgD1s1wD/y0SJA?=
 =?us-ascii?Q?abiHmwe2SF5BzETDKKRGJ5xld7K4KYyaHsqWKKOhTLU5Fd7w3JGxeOfnm+hS?=
 =?us-ascii?Q?n+lyAUaC/sErobubsKqFoW+yNy4ej/yK1XK9hwTOrs/kGeYM9Q9mvu4Qc5eW?=
 =?us-ascii?Q?ukmGim6Fhjtg2Cpy9IKuw/BwtzLtM1MMhHl2vMH4xw2kyDRTt7np11UzPEaS?=
 =?us-ascii?Q?H0yGSmhcztX/Iy+iQ5FUaXnSeRFHSL3NSXTn5WdHpbw3AYScv0N41kdhzTFm?=
 =?us-ascii?Q?9SEYvA4um/n5W0NUCnsm0imvJ6QGolCiG7nUXEd7s6SNGo6Za4rdnFt2eykq?=
 =?us-ascii?Q?POetLc/nxBrPnELu9VVnd4ayglHYwLya4b/BNuqRZbzUH0Fj1s5IMFKRL4Fb?=
 =?us-ascii?Q?8/THdXHNbGlKJ5nYD9iECFH9w6FkVOupN1LkKah0P7Oay0W2yrNhXXpYqwUn?=
 =?us-ascii?Q?iDtgefiN1kI6+k5ePosjaZtCyrfr90mXnI8RsJtLa4Oq32myzR2AQDZbc/qr?=
 =?us-ascii?Q?0Dt0XjeFsZGlLfi7y+KULsudQ0dVXXHFW3PpFhgYqjCYibqOdgZjW6nN1OMo?=
 =?us-ascii?Q?q9c54OVAHW3q50VBNwLYk+DsnlbVO+l8l7fFM6N7vQGzF736E5FrnlWfsWNV?=
 =?us-ascii?Q?6ENKYF2VeJ4jjS6/0Ik2QBjeKs9ke+og9Y5V3I+WYMsb19CXQfbELJxPYXDB?=
 =?us-ascii?Q?mwqgg2vJ3nDqHkGwxiaPiLekKRAHkKDwKNnj6WmCEF4OQ2PAfXUYtWGoA5KF?=
 =?us-ascii?Q?pojxCEN75TnBldCBHpO5sLfPpmNITbWuQYOYXKzKPZY/jcehkS0M6j/bPxRa?=
 =?us-ascii?Q?PqWVoo3ie2TOIxKtI8r0FEvz9/+Jb6a7c8PdCZ/foAFiMZjYhKg0JxQ2uYsL?=
 =?us-ascii?Q?ZtR+ZHm80wQ9Q/wGZyOibYfz6O5aXgj8MtYlZGTI4MQSeMzmgh0m2A0V5q/M?=
 =?us-ascii?Q?0o7zqDikuLXnCDEI07UyB+hktnvRrD8sQoTNp3e5D8IQTkrSd9YdolrJAQsb?=
 =?us-ascii?Q?Zh7sGwjSfiMN71gLP2KoUWdJk7WatBHPUqidjlbNzAPjutia/1MZ4BUchlPA?=
 =?us-ascii?Q?sTTH5A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e0d5d6b-8c69-4bc6-709e-08d9c004b200
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB2576.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2021 19:54:25.0020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B7Sh7NbiGuiwinVAK8s3Kt9rhVg+nVbNsWzSntVu8LF60tla9xUglyJ/aXjcPGskcoj9dnATj7VnLl9fhCXUUm3t3yB4WRxrqx6LphhzJ4A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3023
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10199 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112150109
X-Proofpoint-ORIG-GUID: LcS5CTHcNc-aXn_DIwC5E08zjLTo-XYa
X-Proofpoint-GUID: LcS5CTHcNc-aXn_DIwC5E08zjLTo-XYa
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2021-12-15 11:49:34 -0600, Michael Roth wrote:
> 
> I think needing to pass in the SME/SEV CPUID bits to tell the helper when
> to parse encryption bit and when not to is a little bit awkward though.
> If there's some agreement that this will ultimately serve the purpose of
> handling all (or most) of SME/SEV-related CPUID parsing, then the caller
> shouldn't really need to be aware of any individual bit positions.
> Maybe a bool could handle that instead, e.g.:
> 
>   int get_me_bit(bool sev_only, ...)
> 
>   or
> 
>   int sme_sev_parse_cpuid(bool sev_only, ...)
> 
> where for boot/compressed sev_only=true, for kernel proper sev_only=false.

Implemented using this suggestion, and the patch is at the end.

I feel that passing of "true" or "false" to get_me_bit_pos() from
sev_enable() and sme_enable() has become less clear now. It is not
obvious what the "true" and "false" values mean.

However, both implementations (Tom's suggestions and Tom's + Mike's
suggestions) are available now. We can pick one of these, or I will redo
this if we want a different implementation.

Venu

---
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7a5934af9d47..eb202096a1fc 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -17,6 +17,48 @@
 #define GHCB_PROTOCOL_MAX	2ULL
 #define GHCB_DEFAULT_USAGE	0ULL
 
+#define AMD_SME_BIT		BIT(0)
+#define AMD_SEV_BIT		BIT(1)
+
+/*
+ * Returns the memory encryption bit position,
+ * if the specified features are supported.
+ * Returns 0, otherwise.
+ */
+static inline unsigned int get_me_bit_pos(bool sev_only)
+{
+	unsigned int eax, ebx, ecx, edx;
+	unsigned int features;
+
+	features = AMD_SEV_BIT | (sev_only ? 0 : AMD_SME_BIT);
+
+	/* Check for the SME/SEV support leaf */
+	eax = 0x80000000;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+	if (eax < 0x8000001f)
+		return 0;
+
+	eax = 0x8000001f;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+
+	/* Check whether the specified features are supported.
+	 * SME/SEV features:
+	 *   CPUID Fn8000_001F[EAX]
+	 *   - Bit 0 - Secure Memory Encryption support
+	 *   - Bit 1 - Secure Encrypted Virtualization support
+	 */
+	if (!(eax & features))
+		return 0;
+
+	/*
+	 *   CPUID Fn8000_001F[EBX]
+	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
+	 */
+	return ebx & 0x3f;
+}
+
 #define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
 
 enum es_result {
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index c2bf99522e5e..9a8181893af7 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -291,6 +291,7 @@ static void enforce_vmpl0(void)
 void sev_enable(struct boot_params *bp)
 {
 	unsigned int eax, ebx, ecx, edx;
+	unsigned int me_bit_pos;
 	bool snp;
 
 	/*
@@ -299,26 +300,9 @@ void sev_enable(struct boot_params *bp)
 	 */
 	snp = snp_init(bp);
 
-	/* Check for the SME/SEV support leaf */
-	eax = 0x80000000;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	if (eax < 0x8000001f)
-		return;
-
-	/*
-	 * Check for the SME/SEV feature:
-	 *   CPUID Fn8000_001F[EAX]
-	 *   - Bit 0 - Secure Memory Encryption support
-	 *   - Bit 1 - Secure Encrypted Virtualization support
-	 *   CPUID Fn8000_001F[EBX]
-	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
-	 */
-	eax = 0x8000001f;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	/* Check whether SEV is supported */
-	if (!(eax & BIT(1))) {
+	/* Get the memory encryption bit position if SEV is supported */
+	me_bit_pos = get_me_bit_pos(true);
+	if (!me_bit_pos) {
 		if (snp)
 			error("SEV-SNP support indicated by CC blob, but not CPUID.");
 		return;
@@ -350,7 +334,7 @@ void sev_enable(struct boot_params *bp)
 	if (snp && !(sev_status & MSR_AMD64_SEV_SNP_ENABLED))
 		error("SEV-SNP supported indicated by CC blob, but not SEV status MSR.");
 
-	sme_me_mask = BIT_ULL(ebx & 0x3f);
+	sme_me_mask = BIT_ULL(me_bit_pos);
 }
 
 /* Search for Confidential Computing blob in the EFI config table. */
diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 2f723e106ed3..a4979f61ecc7 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -508,38 +508,19 @@ void __init sme_enable(struct boot_params *bp)
 	unsigned long feature_mask;
 	bool active_by_default;
 	unsigned long me_mask;
+	unsigned int me_bit_pos;
 	char buffer[16];
 	bool snp;
 	u64 msr;
 
 	snp = snp_init(bp);
 
-	/* Check for the SME/SEV support leaf */
-	eax = 0x80000000;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	if (eax < 0x8000001f)
+	/* Get the memory encryption bit position if SEV or SME are supported */
+	me_bit_pos = get_me_bit_pos(false);
+	if (!me_bit_pos)
 		return;
 
-#define AMD_SME_BIT	BIT(0)
-#define AMD_SEV_BIT	BIT(1)
-
-	/*
-	 * Check for the SME/SEV feature:
-	 *   CPUID Fn8000_001F[EAX]
-	 *   - Bit 0 - Secure Memory Encryption support
-	 *   - Bit 1 - Secure Encrypted Virtualization support
-	 *   CPUID Fn8000_001F[EBX]
-	 *   - Bits 5:0 - Pagetable bit position used to indicate encryption
-	 */
-	eax = 0x8000001f;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-	/* Check whether SEV or SME is supported */
-	if (!(eax & (AMD_SEV_BIT | AMD_SME_BIT)))
-		return;
-
-	me_mask = 1UL << (ebx & 0x3f);
+	me_mask = BIT_ULL(me_bit_pos);
 
 	/* Check the SEV MSR whether SEV or SME is enabled */
 	sev_status   = __rdmsr(MSR_AMD64_SEV);
