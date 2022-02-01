Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CD14A65C3
	for <lists+linux-efi@lfdr.de>; Tue,  1 Feb 2022 21:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236703AbiBAUfb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 1 Feb 2022 15:35:31 -0500
Received: from mail-mw2nam10on2056.outbound.protection.outlook.com ([40.107.94.56]:6048
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229702AbiBAUfa (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 1 Feb 2022 15:35:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gWT4pzn9r7IKr0xW0KpVtMcU/ypjB+LlyTSSaC2X/ZxLzXYSCnBWl4VIiSncZ+qZlwnmQzll5HeYegoFtezXOX2JcmIV9iE9BdG41HAMTWRMa2kjcLC4jcFDRRvDpYmO+iySqqLTH3z4cYalvSaOd2dLDWQMhAL8P+pjRbNwVeknxY9uGK043o/Up1S5nzmJrDMtpH63kaXwMiUH2z/fySF5ZGAJpSanPnOSx9CDHQEOQhsupw2n00hyMOtUQzHKHhCQtrRNVlSc8gy0sB4LvqRUEYcMXKXI7j2UmmtKQpi9fzm2H/++UOeUMjHct4g+uQmrjN1jZrfvXLmV173a6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v1cWBqOIXa7ardxwCFEaPnr5lv2sy+HvYwvTKBY+L3U=;
 b=HzaiSwcDDOjai2WK7SAR62r4QFlThjvCX9fUt5HRHWrccBHSwX5d1cRx2iIME/zX4k0Y4WATFEukv3C7uV7yOpztPmlCnAZsKRS+eUdit4aB72+uOUxbHdJxAhrGbDNexMiSu2TKr7tGzNFdN89Gg1fWFVnunjnqZolZQja1t4WXetSl7O7XGPAyWfQn4iFvG1FuCylko8OeeLUbIsZkyQ4gJCQ3OWQo0kGBjwvKZxSjeC/2e8LlerdQk7SsTpINuYWkMaGqL+hgVAb/aa0kNyMy3Fq+WMuDcYj22Pd8UzPaMdgu+ojpITZEaO5ZALE1ycaVE/1UJoCw1SCHoOdh2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v1cWBqOIXa7ardxwCFEaPnr5lv2sy+HvYwvTKBY+L3U=;
 b=ROo/lJbjEBL+j0pSK9ekysY4tG+2hPZ0xxX+7/Od4QAIxO+CSEmTDKR/ISOZRIsKE8HrrxshyCX80dJij4FAFZI8wVo8258mrde6yfHlZvwD3ofCCK5OqOzbcjF3ocd5g8mDnA6YSQXHGKGFeE1YTIrYqwytQEvpwgDXvjbOuog=
Received: from MW4PR04CA0175.namprd04.prod.outlook.com (2603:10b6:303:85::30)
 by DM5PR12MB1836.namprd12.prod.outlook.com (2603:10b6:3:114::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.20; Tue, 1 Feb
 2022 20:35:28 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::9a) by MW4PR04CA0175.outlook.office365.com
 (2603:10b6:303:85::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Tue, 1 Feb 2022 20:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 1 Feb 2022 20:35:26 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Tue, 1 Feb
 2022 14:35:25 -0600
Date:   Tue, 1 Feb 2022 14:35:07 -0600
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Brijesh Singh <brijesh.singh@amd.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>,
        <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        "Vitaly Kuznetsov" <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sergio Lopez <slp@redhat.com>, Peter Gonda <pgonda@google.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tobin Feldman-Fitzthum <tobin@ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andi Kleen <ak@linux.intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        <brijesh.ksingh@gmail.com>, <tony.luck@intel.com>,
        <marcorr@google.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v9 05/43] x86/compressed/64: Detect/setup SEV/SME
 features earlier in boot
Message-ID: <20220201203507.goibbaln6dxyoogv@amd.com>
References: <20220128171804.569796-1-brijesh.singh@amd.com>
 <20220128171804.569796-6-brijesh.singh@amd.com>
 <Yfl3FaTGPxE7qMCq@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yfl3FaTGPxE7qMCq@zn.tnic>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1ce8c51c-11f0-492d-5319-08d9e5c26168
X-MS-TrafficTypeDiagnostic: DM5PR12MB1836:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB183658D8FAC3A10AA6E93A5695269@DM5PR12MB1836.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMY8/u+KwN9O6JsVkbpMbU++NQqVAHPuUDLFJ9QFEQ7Z8UIxWF8+/FaZ343gYNrlLhNCal1+KV5UaI7es1sIFW9D0mEFZwUghuC6jUnTJFkIn0keXl723MfRavYAAB6n3bN1MfNik+vr3CRNqUExgo5pObjRiYHS70a4DiTPd4RPHTCpUjD7j68mxN2b6TbUAPyqUAKFOF1ZU6VXOlG95MNTfyFhUpbE3jT42Jyj9JYWXIczDG4KKdMoJtoSBw+LupWefuxoQkl9Z4tjFQbQvCg3b27kkWmfX6V3xHDa2OIkdlOXz9tmssPKda4XjRy6gDZlKUn0VAWLSUO9wph1DgMSOee1GUhMlbDZWKdM2/RjNS4Ya7hS3PDMSDvoY5LkMe/tUKX9QQl6QLE1UVmXDIl6OuZ/UmOwclkUPjAd+LvCzGOMIK1R1SE+dxX9/IGJord2N8Zkk+xtlTbCxqEPvT1jLZuLMk0kSVXGdUjBVqhZru2E63UMOCUCY/Uc2zgVaeZo/hIQisCEmr7GOCq5Fy7KBn6scpCUD0tKnA43ZR4AwSDvNIpx8BjO1MibGAzKIODAlQUwTz/stLv8Op4Phr2f2m+Qoob76G3U16IA6QDrLdznTELNRDUuVDWsfY36tfkxwidJYuoN9ZBrowhrLx4s98S6oW61GKucu+7VeyMm69lhn+FYdXKSJSO9AvE+4/p3Np9JtDL+GK0zQcsDO4xgao2S0UWIWs+PGfl2Yfg/nuU2ZeWlck8oRg6pPWuPuYzHQvEKzYvyHppKaWhhkXP4MIoEoGqIbwYS3blEw3M=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70206006)(70586007)(508600001)(81166007)(8676002)(8936002)(6666004)(4326008)(316002)(36756003)(6916009)(40460700003)(54906003)(47076005)(966005)(356005)(82310400004)(336012)(186003)(2906002)(7416002)(7406005)(16526019)(26005)(2616005)(44832011)(36860700001)(5660300002)(86362001)(1076003)(45080400002)(426003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 20:35:26.8404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce8c51c-11f0-492d-5319-08d9e5c26168
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1836
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Feb 01, 2022 at 07:08:21PM +0100, Borislav Petkov wrote:
> On Fri, Jan 28, 2022 at 11:17:26AM -0600, Brijesh Singh wrote:
> > diff --git a/arch/x86/boot/compressed/head_64.S b/arch/x86/boot/compressed/head_64.S
> > index fd9441f40457..49064a9f96e2 100644
> > --- a/arch/x86/boot/compressed/head_64.S
> > +++ b/arch/x86/boot/compressed/head_64.S
> > @@ -191,9 +191,8 @@ SYM_FUNC_START(startup_32)
> >  	/*
> >  	 * Mark SEV as active in sev_status so that startup32_check_sev_cbit()
> >  	 * will do a check. The sev_status memory will be fully initialized
> 
> That "sev_status memory" formulation is just weird. Pls fix it while
> you're touching that comment.

Will do.

> 
> > +static inline u64 rd_sev_status_msr(void)
> > +{
> > +	unsigned long low, high;
> > +
> > +	asm volatile("rdmsr" : "=a" (low), "=d" (high) :
> > +			"c" (MSR_AMD64_SEV));
> > +
> > +	return ((high << 32) | low);
> > +}
> 
> Don't you see sev_es_rd_ghcb_msr() in that same file above? Do a common
> rdmsr() helper and call it where needed, pls, instead of duplicating
> code.

Unfortunately rdmsr()/wrmsr()/__rdmsr()/__wrmsr() etc. definitions are all
already getting pulled in via:

  misc.h:
    #include linux/elf.h
      #include linux/thread_info.h
        #include linux/cpufeature.h
          #include linux/processor.h
            #include linux/msr.h

Those definitions aren't usable in boot/compressed because of __ex_table
and possibly some other dependency hellishness.

Would read_msr()/write_msr() be reasonable alternative names for these new
helpers, or something else that better distinguishes them from the
kernel proper definitions?

> 
> misc.h looks like a good place.

It doesn't look like anything in boot/ pulls in boot/compressed/
headers. It seems to be the other way around, with boot/compressed
pulling in headers and whole C files from boot/.

So perhaps these new definitions should be added to a small boot/msr.h
header and pulled in from there?

> 
> Extra bonus points will be given if you unify callers in
> arch/x86/boot/cpucheck.c too but you don't have to - I can do that
> ontop.

I have these new helpers defined with similar signatures to
__rdmsr/__wrmsr:

  /* rdmsr/wrmsr helpers */
  static inline u64 read_msr(unsigned int msr)
  {
         u64 low, high;
  
         asm volatile("rdmsr" : "=a" (low), "=d" (high) : "c" (msr));
  
         return ((high << 32) | low);
  }
  
  static inline void write_msr(unsigned int msr, u32 low, u32 high)
  {
         asm volatile("wrmsr" : : "c" (msr), "a"(low), "d" (high) : "memory");
  }

but cpucheck.c code flow really lends itself to having a read_msr()
variant that loads into 2 separate high/low u32 values, like what
native_rdmsr does:

  #define native_rdmsr(msr, val1, val2)                   \
  do {                                                    \
          u64 __val = __rdmsr((msr));                     \
          (void)((val1) = (u32)__val);                    \
          (void)((val2) = (u32)(__val >> 32));            \
  } while (0)

Should we introduce something like this as well for cpucheck.c? Or
re-write cpucheck.c to make use of the u64 versions? Or just set the
cpucheck.c rework aside for now? (but still introduce the above helpers
as boot/msr.h in preparation)?

Thanks,

Mike

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7Cec7f8621a6934039cfff08d9e5addaca%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637793357136301050%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&amp;sdata=FMoP5ZskuxwanWTe5DxMnIYNPBSi%2FhRrOExp9hIHaCo%3D&amp;reserved=0
