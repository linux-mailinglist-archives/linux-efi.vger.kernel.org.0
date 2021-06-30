Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8933B7BFE
	for <lists+linux-efi@lfdr.de>; Wed, 30 Jun 2021 05:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhF3DM6 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Jun 2021 23:12:58 -0400
Received: from mail-co1nam11on2057.outbound.protection.outlook.com ([40.107.220.57]:1027
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232009AbhF3DM5 (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 29 Jun 2021 23:12:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMBRC44Szq60N/ClyuPw1rMeH1uXfT7bNbrJEPp8UJGhoAy4tesjMl/oNnRlLHSoTcODOs25Ntg1SUZfU/04UWmA8bLYls5qHf8+PVoRr/4vV7Nsr2A12UM6enLHe7j67vqujnmRkRBzA/xvwsc2OfxOSyOheP/oM/Tl8TyFc3PMz9Qr67LmWWahwTdShUm5X6VRN5CtPP82QVqeLmeiTKP9S7NYoCdc1d0euHKQmulx5tzruPASL4cmMSer+ihGylXWGWFAq0C8MTIqjRemmGFSpTYqu7EHrEEbhINgO5sxO4jPrcsUhq296pSaA71X9NqcAPJ6pbAi3YUAISEPag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG5uF3XhLImh77DwZULkD3Bp4JmDrLkV7OlyOSXfIx0=;
 b=DbYEls47Vs8HtZ74uL+qjuxKbDu0iOBF5MGa6KUZvHcn2x2J4O2NkjFSyToECKFws1LHVb94RFL5Y7fAyIEdepj8v4GXsaCT1eMvQtORwYjqLNeuwkUzyNNC6ekhJt3OBNJZi6nmjIsfE6plZQmez1lk3OD8lkXMB5XYnqAQzpVCA++9RZWi+pS3006I0bTuSdHs3weYjxbZ9ioT5u7DYCHrdo3VHIM3dKjNbL1ZwJOP6XG+N2UAH6yFaGqhvT3sMjorYzypElUqu6a+z5kmvr54X6IOBn2dhFRyNLx8Jtq2v508qVBY6ZNvgf55io0gJKGAa82CbB+ZCaKb2GRuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fG5uF3XhLImh77DwZULkD3Bp4JmDrLkV7OlyOSXfIx0=;
 b=DEcCG2D77ca8WcbPpt1UlknOH78pVL9m0x+sR2GCqWi5I+EUbxpGxz61dA1A3LbV1LehshpRc5hB/b3mdBLJ6O3YDMDKacNJh8e42hutfrZe3+Sg1Rbeoda8DGvp9LeVYoI5Qq/bOL8G3y7y0DMCSC2WPFNMLOHxiUhodqUj/iA=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by SN1PR12MB2509.namprd12.prod.outlook.com (2603:10b6:802:29::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.20; Wed, 30 Jun
 2021 03:10:27 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::958d:2e44:518c:744c]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::958d:2e44:518c:744c%7]) with mapi id 15.20.4264.027; Wed, 30 Jun 2021
 03:10:26 +0000
Date:   Wed, 30 Jun 2021 03:10:18 +0000
From:   Ashish Kalra <ashish.kalra@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     pbonzini@redhat.com, seanjc@google.com, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com, joro@8bytes.org,
        Thomas.Lendacky@amd.com, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, srutherford@google.com,
        brijesh.singh@amd.com, linux-efi@vger.kernel.org
Subject: Re: [PATCH v3 3/5] mm: x86: Invoke hypercall when page encryption
 status is changed
Message-ID: <20210630031018.GA3373@ashkalra_ubuntu_server>
References: <cover.1623174621.git.ashish.kalra@amd.com>
 <41f3cc3be60571ebe4d5c6d51f1ed27f32afd58c.1623174621.git.ashish.kalra@amd.com>
 <YMJaXGoVMzyR/cP6@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YMJaXGoVMzyR/cP6@zn.tnic>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN4PR0401CA0023.namprd04.prod.outlook.com
 (2603:10b6:803:21::33) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ashkalra_ubuntu_server (165.204.77.1) by SN4PR0401CA0023.namprd04.prod.outlook.com (2603:10b6:803:21::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.19 via Frontend Transport; Wed, 30 Jun 2021 03:10:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de7f753b-79d1-44bb-725b-08d93b749b8c
X-MS-TrafficTypeDiagnostic: SN1PR12MB2509:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB250999A06E30267C9FE16D578E019@SN1PR12MB2509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y4Pln0LpJIj5lfeluAooMA6BgJac0BgNRe8TaAYQNeaK/AoEknLjRAqbR22fvwYDVcm9ewireunKPOros5sjKjlqJ5fkf+6Cs1v14wJrwzdnNQxqDj4tIjrlIRl+qFIurT/shFVSPePSjwt9qGC8XCY351fcM+kt88hPxLmKjHBIBQGBmGI8MgSSBfjOmFhrH2y9eoIAMwfpJOkQ1ciqDL5AEGHlvAxAqJsuKzaDs/uwfi6qRgiK863lQsqJO7t+uhhp7ipVTnDMmTZKAFR7ZK5469o6Qw/xKxk+cdH54kPjYWrzmgRZEVzg0BdARU1+dk1Vzy3HSZ4l4G2FhNMu14CmMV0cN3NJQU4tE1WD0BsLotPJp2lDsbdzC8SBtJn7ITdFxGL21Y5fS+/AIn5TwS98gn2T+WC0UfApEMl47yI2/crAX2XOVm2xcxiBDnSUdMpKXtT5RLt1ukAu01EV8l5hF3OhpfaZFyWHZFPW0FKaA6VbD+2cFIa8vzcXfQJ+fjn5NhbfX0lM1ilCJzwEKUKqoICCTcTl/wcmjhhJU2iQLAIGDZlQZqJg+D5oLIK5DAtaFUNxCuZqyNUK+Em7vxGwhqwP9k6FgocCwUD7L3ufeefEixOkjoZRsaR/8nv16JVaXgsEPZaIAcVDPNMG9wVVY2aX3LK+9vATVR83AenqIBd8toztomJKbbvsgIL3pLDSi60xvu+xLzyV/6+Zw1Gj21VhRoSx7+o1s91Bl+lCt0XX4hB+nAVJWFbYj/aWNOiScWh8a6ppkUsgj5qzXI4DvQQ82Zww20tTdYbw+4YW1pjEjNMkKucUVJ2Td5+dxxbOe2mBZOM9iEvcWZt5Lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(316002)(66946007)(52116002)(66556008)(966005)(86362001)(66476007)(26005)(7416002)(6916009)(44832011)(5660300002)(2906002)(33656002)(4326008)(6666004)(33716001)(8936002)(45080400002)(1076003)(8676002)(16526019)(38350700002)(9686003)(478600001)(186003)(38100700002)(6496006)(956004)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fSUjJGVYmLUfz6Wxi3jMx2Wb6NDte92PF2CLax41addjQOCBrxIys4uKhgyN?=
 =?us-ascii?Q?bSWnUx1KbSNg0a0BaGFk9J2ol+OruqXpcc+4cxgNrzWzK7LKokbkQwxonR5l?=
 =?us-ascii?Q?G3a5tykXvv806INjbm8LIcuWMCIHrboAWaMUFvMgWl8Zp+H8ccyQA/+UYBwc?=
 =?us-ascii?Q?3VY+1mABzl+J6rN1QUwO9qCLr37Eu7/d3UFHc9c169OQFsLRHsAoNEwczDhz?=
 =?us-ascii?Q?8DF6mK9WjOtYVFxEB/sOqom4LDdLsWP3l5rkYM9IG2uAIppKud1+J39bhSgc?=
 =?us-ascii?Q?cmfueWT//5GgcFBoIl2pJaYkdv+30k6s1xlmP/7qovM/7/lWJTRqQ1wrLk6Q?=
 =?us-ascii?Q?SD8WFjvoiy9VO1l0J1O4xjw/iOZkIzNOJwFziDp/olgZhMH7DravJfAg6ZeR?=
 =?us-ascii?Q?YtCZGTVt4ihZOplLVLnWWLbqjbBzwljYKFRVCjrh6wa+tp0XFbA4X1QGhoBK?=
 =?us-ascii?Q?SAmJxjEDjZZSl6dT5yqL9rFxVKwmj1FmCTEFV8dT11jF5S7w+cGYGPxlMZ96?=
 =?us-ascii?Q?P+/gZ+R9oCRWsCPy1XB5q4Br6N4cGud8mGTr9wHVIdi1Gm3NxhMeBV9WBnKz?=
 =?us-ascii?Q?x8d5n5/HvIJeB6EOFqTTeIT0kRNLCalIn/r/9WAMLDlS3dNowbAEcjB3SJXw?=
 =?us-ascii?Q?L+9fatCwkpDCTsCv2YwZ4TionTs3ajKlmYAF4SRQZeftDQDHp+6tQJtzaiIM?=
 =?us-ascii?Q?29QAskqjxddQ2qU4ug4EhLj9hNvXD7l6qhKmQEBtsotUlLnl2O5LIoi0bJLX?=
 =?us-ascii?Q?BwMjINkQHCdQT2Iu/3vzXhoKQgC0r3LR/Q+Pt6VDIzePyzV1Bp0JjSpijbUe?=
 =?us-ascii?Q?XRg3q+O6uDoUzYzKWOusFr+zq+YyC4CpfvX2wMrtpdqF+7Cva2dWamox5weD?=
 =?us-ascii?Q?lQ5TOaARtebdbyrY/jurQpu2vPujI9GxMoZIGojiFPnsa0WgIU3uehK8qUv3?=
 =?us-ascii?Q?Wmts1vpXH6+ugfRsAr3hSxYein4lTLZzmZPKc4GnMi2O/OpjO6aglSIQYAQq?=
 =?us-ascii?Q?i/XNeQkm8TWuWe1x9Qpp+raHrMS8IX0yfNPPpZCEX1gl7V0pfQnBClqcoQl+?=
 =?us-ascii?Q?EMCGEak5WB2QOBPJ1IdQUyMx9w4odgSjR/8nBrlyfPzFLRkbCbBuqzZ6ZU9L?=
 =?us-ascii?Q?MlmJ7NYSOIgAA+JH8jkfvJvaSYOrY1WLyXLY5kN8a28SKqJ1jWBzJHI8A65K?=
 =?us-ascii?Q?BDX9C8SdvkwqcCf6be+OWxACWg/azJ8N0CU9iNo+s3DgnVDAh1gNGZCk5Ts5?=
 =?us-ascii?Q?IgUtZ/05lvqqCTwdQyMYL8cdUOA3nm6KhVjWwepBMwNSUzPZHfjEG3UJyJUD?=
 =?us-ascii?Q?2zB80kPW4TiL7nvRm/8whCuw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7f753b-79d1-44bb-725b-08d93b749b8c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2021 03:10:26.8110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GGiwE5zBXq5qsqdTLDTtYoeGBg3onj32S24+rWBEsxjlQaXLXf5jsAh9QMHYl+nwSyPy1CaKz0LazK1tcPstoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2509
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Boris, Paolo,

On Thu, Jun 10, 2021 at 08:30:52PM +0200, Borislav Petkov wrote:
> On Tue, Jun 08, 2021 at 06:06:26PM +0000, Ashish Kalra wrote:
> > +void notify_range_enc_status_changed(unsigned long vaddr, int npages,
> > +				    bool enc)
> 
> You don't need to break this line.
> 
> > @@ -285,12 +333,13 @@ static void __init __set_clr_pte_enc(pte_t *kpte, int level, bool enc)
> >  static int __init early_set_memory_enc_dec(unsigned long vaddr,
> >  					   unsigned long size, bool enc)
> >  {
> > -	unsigned long vaddr_end, vaddr_next;
> > +	unsigned long vaddr_end, vaddr_next, start;
> >  	unsigned long psize, pmask;
> >  	int split_page_size_mask;
> >  	int level, ret;
> >  	pte_t *kpte;
> >  
> > +	start = vaddr;
> >  	vaddr_next = vaddr;
> >  	vaddr_end = vaddr + size;
> >  
> > @@ -345,6 +394,8 @@ static int __init early_set_memory_enc_dec(unsigned long vaddr,
> >  
> >  	ret = 0;
> >  
> > +	notify_range_enc_status_changed(start, PAGE_ALIGN(size) >> PAGE_SHIFT,
> > +					enc);
> 
> Ditto.
> 
> >  out:
> >  	__flush_tlb_all();
> >  	return ret;
> > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > index 156cd235659f..9729cb0d99e3 100644
> > --- a/arch/x86/mm/pat/set_memory.c
> > +++ b/arch/x86/mm/pat/set_memory.c
> > @@ -2020,6 +2020,13 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
> >  	 */
> >  	cpa_flush(&cpa, 0);
> >  
> > +	/*
> > +	 * Notify hypervisor that a given memory range is mapped encrypted
> > +	 * or decrypted. The hypervisor will use this information during the
> > +	 * VM migration.
> > +	 */
> 
> Simplify that comment:
> 
>         /*
>          * Notify the hypervisor about the encryption status change of the memory
> 	 * range. It will use this information during the VM migration.
>          */
> 
> 
> With those nitpicks fixed:
> 
> Reviewed-by: Borislav Petkov <bp@suse.de>
> 
> Paulo, if you want me to take this, lemme know, but I think it'll
> conflict with patch 5 so perhaps it all should go together through the
> kvm tree...
> 

Will these patches be merged into 5.14 ?

I have posted another version (v5) for patch 5 after more review comments
from Boris, so please pull in all these patches together. 

Thanks,
Ashish

> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CAshish.Kalra%40amd.com%7C142a30170b8145b44a2f08d92c3de599%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637589466634224968%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=nCXHGP8%2F9on0DurrLLbBT0MivMWXfNqwS73rKkqclUM%3D&amp;reserved=0
