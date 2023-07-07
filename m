Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F57174B41A
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jul 2023 17:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbjGGPZy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 7 Jul 2023 11:25:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGGPZx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 7 Jul 2023 11:25:53 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96424AF;
        Fri,  7 Jul 2023 08:25:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aR4i8G3fted6QbGmPn4qcd3DP/SOTDI41MtOBn3BmPrXf2s4cDK61wV7abC6fZRg5kthyQkBpEqmWC9VVqE77TR2MqDAasnKkSwOXa8rRHo0z6AWpmSM+0l2f9lAWCf25eQFygYJpFaXaOaY3LHiSzW6RenWnh+6lnBcVWlwLxoUNyv9WF1aEM58jMsEEUw53+glIwq1gJBBIdu9rVQBq5tSn8o62S77m3C6+wnpNOA2Kf+cnNo5hhMR7cQCBmxg/VfbNt/gWqByEET/lPWcry/3+9WrtLsvmU/7wQPMbIrJPWMPZf4xS+NHZL9ksYyGksWOqU/8FjJXM8lRk6YTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoOBaBpcAOqicUy4XZCAnIxuY1RTs1oIPZtqOkW1qPs=;
 b=mrBuYq6UnFO0HE91V2IJnjLWPvzWt3tkdqcgwigLIPcrNQNt0PHWtaIb0vWDU0IpHBfgzt3M1njVlWuuV/UyyEYhmGCczrniXj4oP8XMKV13ZzYpu6xlWVDjgL8eI6tQraTtsftE/n9sFwznKmOU4BxOSBMV0FK2CRzs/rZFNFhOQfWGgYLkfBd5yRtazdnaorfr5yyPOSJBK59E5+CVxmazlrme2B3+HnHMqVyIwND5ZLRzjRqROsyr9EqjgXYbyK/OAchC/vR880N6R0AeUmm6AyIJXPUKjxIFx35qrIr63u9rxftE2CrEioy7+jpLuxwhcF9oVe6yzeau5C2tAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoOBaBpcAOqicUy4XZCAnIxuY1RTs1oIPZtqOkW1qPs=;
 b=IXt+M2/xbh/I0RhJc3/4A7CYSTU6adp93GDWACtiZjxALPkIZVyUKzZCjX9k+IsYyjNuRjLC1oHjPCoKa/pTMs6IIkh29BnXl5SBkQ4zhdFQWX0pylWiohcMZ/284l6kug/XSvnpOHzbQ1QfVIxkqrvxW90nPAa0jNaq0SjrEfM=
Received: from DM5PR07CA0114.namprd07.prod.outlook.com (2603:10b6:4:ae::43) by
 SN7PR12MB6982.namprd12.prod.outlook.com (2603:10b6:806:262::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.24; Fri, 7 Jul 2023 15:25:49 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::f5) by DM5PR07CA0114.outlook.office365.com
 (2603:10b6:4:ae::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24 via Frontend
 Transport; Fri, 7 Jul 2023 15:25:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.45 via Frontend Transport; Fri, 7 Jul 2023 15:25:48 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 7 Jul
 2023 10:25:47 -0500
Date:   Fri, 7 Jul 2023 10:25:15 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     Joerg Roedel <jroedel@suse.de>, Baoquan He <bhe@redhat.com>,
        Tao Liu <ltao@redhat.com>, <thomas.lendacky@amd.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <ardb@kernel.org>, <linux-kernel@vger.kernel.org>,
        <dyoung@redhat.com>, <kexec@lists.infradead.org>,
        <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <20230707152515.42gpfzjgvfwe6rf7@amd.com>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
 <CAO7dBbXdJgpO4Ym=4WME3OOrUhq2MNKpNZmhpsC7pOSugHiKDg@mail.gmail.com>
 <ZKeTX2aemPbsMiVr@MiWiFi-R3L-srv>
 <ZKfLYG_4DANc_i5r@suse.de>
 <20230707085712.GBZKfTaGJXnzhEenxj@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230707085712.GBZKfTaGJXnzhEenxj@fat_crate.local>
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|SN7PR12MB6982:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f04d7a-3288-4868-83f9-08db7efe70f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y1iJfuNRwHClusZmEQwNk8eImRmKsWPAUQneRgq2gnpF8kb04POXebFJJtsjK1gaeG/xXRWEPVJY/368LR97cn42Z7xVs9IrlnOz7bURH2LUhoLr4vJYpDAJ0cBcWDn8Y/OwI86hbP7LZFIge+WZW1c9BkDkyYMBA9fQr2Sj9XwuTRHmI2+V+JcsbMccmkysVYBJ6cwHbCMVljpkXodIJMTij2uLIb6vn8v7y4HHvPsNnbjY+3tfi6FKMYcpr4KDfnduBeQL5gQvGjSyGCwCqZgt1Mu7HOL+Hpku7c/13DY29ppPR8Hsz+tfHlHEg4pswPYvoEX7e40JemTUMZnNGRygZ5XgX3r19mX+DTm2nrp3qOOG2eLicGrGAHd3jGIZ/LMrttRJQJMDbFpe9CsQs3aSk/UOUuEyKxWNAucXpczHSyB97hWvGcNW74i6TqLUKIbZD2SaB7tJAyVVR/8JgEkZdX00GbuFBLKyGoU977eM2gSlHS6hRpCeAzokyaWiBOx5IYb2/gi0MJ0bYohKk37jFbB3ErosjnQZeokkJRvnSO5m/uOyBAUZttBHENzNbtd/qdXRjQ7RlA+jMdgmy53t00fpgf0EfHFL5LXxz+bI24OszRvIsgoO0L54rK2et0IM+oB+GdW1rd5WeQQM9C+m/XCTfcRJt3oxQg+YFtevB/dTPYx0mOshUMC/YKwZXakAyKn+8DMafNv+7UQOrCYTjciSZQ0dmt9pZVwZDHu6nQaP8NFMSq8uEvVwI45AZWRPHEXiN0/ghmV12c/XMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(336012)(83380400001)(1076003)(186003)(26005)(16526019)(426003)(6666004)(47076005)(54906003)(356005)(82740400003)(81166007)(36860700001)(478600001)(2616005)(966005)(8936002)(316002)(8676002)(41300700001)(40460700003)(5660300002)(7416002)(70206006)(44832011)(70586007)(4326008)(6916009)(40480700001)(2906002)(86362001)(82310400005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 15:25:48.3269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f04d7a-3288-4868-83f9-08db7efe70f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6982
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jul 07, 2023 at 10:57:12AM +0200, Borislav Petkov wrote:
> On Fri, Jul 07, 2023 at 10:22:56AM +0200, Joerg Roedel wrote:
> > On Fri, Jul 07, 2023 at 12:23:59PM +0800, Baoquan He wrote:
> > > I am wondering why we don't detect the cpu type and return early inside
> > > sev_enable() if it's Intel cpu.
> > > 
> > > We can't rely on CONFIG_AMD_MEM_ENCRYPT to decide if the code need be
> > > executed or not because we usually enable them all in distros.

If the SETUP_CC_BLOB config table entry isn't present, then none of that
code will run. I think the patch here addresses the main issue: kexec
has handed us a SETUP_EFI setup_data entry, with a pointer to a valid
config table, but we don't map it before accessing it. I should have
done a better job of checking for this, since there has been similar
cases exposed by the SEV checks, e.g.:

  commit b57feed2cc2622ae14b2fa62f19e973e5e0a60cf
  Author: Michael Roth <michael.roth@amd.com>
  Date:   Tue Jul 5 21:53:15 2022 -0500

      x86/compressed/64: Add identity mappings for setup_data entries

but I don't think there's anything inherently wrong with accessing the
EFI config table in early boot. SEV is earliest user now, but something
else can come along. We certainly have early access to EFI system table
and other bootparams fields like ACPI RDSP in this neck of the woods.

So regardless of how we decide to handle sev_enable(), I think this patch
should be applied, rather than allowing this to lurk in the shadows until
it claims its next victim.

> > 
> > Looking at the code in head_64.S, by the time sev_enable() runs the SEV
> > bit should already be set in sev_status. Maybe use that to detect
> > whether SEV is enabled and bail out early?

sev_enabled() is actually what sets sev_status global, but for startup32
path, the SEV_ENABLED bit is artificially set earlier to force the C-bit
check in startup32_check_sev_cbit():

  fef81c8626: x86/boot/compressed/64: Check SEV encryption in the 32-bit boot-path

> 
> There was something about getting the CPUID page on SNP *before*
> actually calling CPUID but this is not the first time we had trouble in
> this area. This needs to be done differently.
> 
> Michael?

The main issue is we don't know when it is safe to access the SEV_STATUS
MSR until we've checked for the CPUID bit that advertises SEV
capability, otherwise we can generate a #GP on machines that don't
support it.

With SNP, the most reliable way to access this CPUID bit is via the SNP
CPUID table entry corresponding to 0x8000001F, rather than the emulated
values provided by hypervisor, like we do with SEV-ES. So that's how
things are implemented currently.

We *could* instead revert back to using the hypervisor-provided CPUID
values for 0x8000001F, as with SEV-ES, which would allow us to check
SEV_STATUS MSR *prior* to SNP CPUID table setup, instead of afterward...

What's awkward about that approach is that we'd effectively be bypassing
all the validation that the SNP firmware does on the 0x8000001F leaf. In
general this seems backwards, however:

  a) we still have the option of re-checking the 0x8000001F leaf once
     the SNP CPUID table is setup to see if the hypervisor presented
     something different to the guest than what we were expecting
  b) in this *specific* case, we only need to check for SEV CPUID bit
     so we know it is safe to check SEV_STATUS MSR. A malicious
     hypervisor can:

       i) trick us into causing a crash via the MSR access: but that's okay,
          security isn't compromised. hypervisor's fault, not ours.
      ii) trick us into thinking SEV is enabled so hypervisor can
          intercept/emulated the MSR access: but that's okay, because
          when SEV is enabled the SEV_STATUS MSR can't be intercepted,
          and if SEV isn't actually enabled, the guest wouldn't get past
          attestation.
     iii) trick us into thinking SEV isn't enabled, which should be fine
          if we leave sev_status unset.

So, yes, we can avoid checking for CC blob by relying on the above
details and reversing the ordering of CPUID table setup and initial
SEV_STATUS MSR checks. But we'd want to similarly audit any changes to these
paths so that an eventual case doesn't pop up where a malicious hypervisor
can cause a certain check/configuration to be bypassed by toying with CPUID
values at this stage of boot, which is why we've so far tried to maintain
the current handling.

It would be unfortunate if we finally abandoned this path because of the
issue being hit here though. I think the patch posted here is the proper
resolution to the issue being hit, and I'm hoping at this point we've
identified all the similar cases where EFI/setup_data-related structures
were missing explicit mappings. But if we still think it's too much of a
liability to access the EFI config table outside of SEV-enabled guests,
then I can work on re-implementing things based on the above logic.

-Mike

> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
