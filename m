Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 818323FB975
	for <lists+linux-efi@lfdr.de>; Mon, 30 Aug 2021 17:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237783AbhH3P5N (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 30 Aug 2021 11:57:13 -0400
Received: from mail-bn8nam08on2060.outbound.protection.outlook.com ([40.107.100.60]:53152
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237646AbhH3P5K (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 30 Aug 2021 11:57:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCscNhcE9ZEBrjUJ3wllsmSIlWtQk3dUu0gAR5wjDiDY0eBEH2XcObMxeffwmWsiooTmA0tBf6KnQt+xQUDXUsc2ouPnETNYb1JrU9m/z7566HJQ6o6LpkU3sGQqPf+faSXLnATzDqmXUBGJ1MustdHzfNNP51KPE6rDN+nVKzZ0DlAA0wvQ8/JIJ+2EMbEGK3FoAbM1YAYMlDDlEoZmrSOipT83vPhgM77RHpT+Zqj01r2oQ28pUVdkPo1wO8SYsCifxKqN+SgOe2hS8ZgQXjNz9RF9ZHkU7krkQQ8wUUrpy+zPwLqaVAA66l2I26MfOZVDHoWTZjjE7uVoYnyqvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJKsr19x22LI+8rezBeREocX0uDPMG2SwjIqi1QLieE=;
 b=bOluLh4jqCXy/ngWILxRfKxVxd5ZJVfQO9jYINhOmjGAPa78+O82R0MCyRvMN5ZnIrcCFI5nyhsN7Vsc4wt27LuKvCoF0nRyCIapzo+N4fuQM1tZkEv+vNqkzU2p3kVUAKGXA3uP0NI8ZG4DMV5KCkzbg1/TeWakCo1kZymzFRXVY8YaNKCkuqxyKG0h50QnK3onvplv2xQc4WesNzNJWzG+zIvOuaNf0L8uTyJlez2jZ6xGgfBB8l0AqR7oAQfNs3mbFbU9+NBW35IZAVzp3lvnTCyaPNI0XA0VN7OYxeZL6uoAPAmATeHYb3SqTJ8t7TTnBh/W0RYqGQ2eFuzNhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJKsr19x22LI+8rezBeREocX0uDPMG2SwjIqi1QLieE=;
 b=mJocYqPJ78N5WveetTpH+CIjygVm19mX8wKewba0M9SWJPIBB4XBU7G/vkxHiQr10MTL7ILZVCgKGtLlvGXqR/ZPNpCgAhoBBS7p8+Wc4cS2Ks0XLpqbJqL7Tnaj1IzgZi8Rpi0hxFbffbwYby/KLsa4hL97htpgxOapllqRgbo=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.24; Mon, 30 Aug
 2021 15:56:13 +0000
Received: from CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0]) by CH2PR12MB4133.namprd12.prod.outlook.com
 ([fe80::d19e:b657:5259:24d0%8]) with mapi id 15.20.4436.019; Mon, 30 Aug 2021
 15:56:13 +0000
Date:   Fri, 27 Aug 2021 14:09:55 -0500
From:   Michael Roth <michael.roth@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-efi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ard Biesheuvel <ardb@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
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
        Andi Kleen <ak@linux.intel.com>, tony.luck@intel.com,
        marcorr@google.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH Part1 v5 30/38] x86/compressed/64: store Confidential
 Computing blob address in bootparams
Message-ID: <20210827190955.fc5eyvk2mmtuawwz@amd.com>
References: <20210820151933.22401-1-brijesh.singh@amd.com>
 <20210820151933.22401-31-brijesh.singh@amd.com>
 <YSjzcgQDubOY1pGI@zn.tnic>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSjzcgQDubOY1pGI@zn.tnic>
X-ClientProxiedBy: SN6PR08CA0014.namprd08.prod.outlook.com
 (2603:10b6:805:66::27) To CH2PR12MB4133.namprd12.prod.outlook.com
 (2603:10b6:610:7a::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (165.204.77.11) by SN6PR08CA0014.namprd08.prod.outlook.com (2603:10b6:805:66::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Mon, 30 Aug 2021 15:56:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a530821-f2b7-42d6-6fc5-08d96bceb0ff
X-MS-TrafficTypeDiagnostic: CH2PR12MB4246:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB4246C669EA7922D9B97891C995CB9@CH2PR12MB4246.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:336;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y1zWxeY/9hRhBXnknPZa2qMAxG2bp2foeWqdS7InmQdfadbcgHedrLn/VwPs5ybNFKiixKXXtRmL5zejZgImCR0ZiYQ/UJsHAVITDQdCm+eIK0Vun/EiSu7cfr+E8isztuEwMbQzT1A5pKvxE2DXCMIm/PsMNXYzVH2W1GSXCKJVFCXv/PtgIbjgWp71r7OnatHoBHcJaj4jx1UsrUo3pp+CF6rRPUdABaev8Ntq3A4wTCc/5IpZaHhq1ClXziXtgSb1hwMVGdNvd7wvhaucODeDReDROFUjTSeh6bFqfXZ7OjWot52eFjz1h+0ADqAFNADsAeMGBSEU2i7bdQEgW+N8otDjPVW43srAcsMAEdm2bY1sKgLrkCoYC/AcR8hlwzwHx7u9aqYzVTX6YawO0VJOJLiSLT5kRYktlSw9Yfey0eR66ZhCSbz80/hYzxewYqXSSybJ81XCZl0inhY/79O+INX3MLxGnlw3yuiy52fMz1ROzIOPBlFeYNuLXJzV6TNBn0XRv4DW3/+H7d9R5OEfcrJxfKIPORnr9/2reYKK4L15/I+3M0AXRI4DkD9xZUyb3opLBjouR6kjTvfw79WrQa2eFoG9WvPXkFysen2mvrrpozFfHaMxatVvNYhWdqqz4o0mHOcKWZH1EDomZ2L1XQBnmY97R920z2XdD1Rn3CAtVdqQTRdlpJgJJpIb+Pm6v6n3gL2Pjd4BxwnXzYjU/yRnyKG3MpyQv++zf8NF7mw565Dl26XknCD9sgZ2nX1FelFgf/fLpdLRMb4I4vb+3tWxgQLimYchMobkWtk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4133.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(186003)(26005)(6916009)(2906002)(52116002)(956004)(44832011)(6496006)(83380400001)(7406005)(4326008)(38100700002)(38350700002)(45080400002)(2616005)(86362001)(6666004)(5660300002)(6486002)(66476007)(478600001)(8676002)(36756003)(54906003)(66946007)(66556008)(1076003)(316002)(966005)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ovEEv0I4l8yHoXtihEpDdciNzz8vWKN83YMFKLDQMXZ77nyKDTMfhPOos4kX?=
 =?us-ascii?Q?DIAevG4XPcuPdT7B28IEtbaidBSNLiwHoOlN/TwoqCThbGGlc7nuHrqkIatZ?=
 =?us-ascii?Q?Dii4Za7B3TwAzivQ6DbkdahBxkuuj9NN9/0bsnNSTFHF9JasEYKiQMEiCCkE?=
 =?us-ascii?Q?CZjG0uabg7Og09hjfA0+fr7dKlAK3jXXR0g67KJ3GqMNKthQ3q7K1SQftp+y?=
 =?us-ascii?Q?QLwUjM0iCSkaPVKwcRhBbgAmWaHSuWvWVU/sBgDpMGxoTBcWN3Xrwj06X0x5?=
 =?us-ascii?Q?KYXC+OxIjam/Q2ot9iC8vbTfPWor0Zi1bQpWtRg//+begJcoSKsHVMTQKJ0C?=
 =?us-ascii?Q?hXrdzIMcXZjxEaRKfedRSYF1Tf2ZkAw8IdAjVrxZsrcbaiNi6MKtYS1xShgs?=
 =?us-ascii?Q?97fd8kWMOvs4OtbQgXXGVWNkSOTLfu1U8azQcuRQDjzI83BSDkrXodRX8fJY?=
 =?us-ascii?Q?ZZke/yzDdP5qatRgs1Fogn5LgsJwEphmknRMtFHvzHUWR90oJ8EZAKDL9NRg?=
 =?us-ascii?Q?hq33wiP7mbKYigEEEBLM7364ZR6UCrbAzw96HDprObwz4oHfERqX/x8g49n5?=
 =?us-ascii?Q?YDY0FTeUeCu+uDF/udOPzLSbUXg0ta4pkzTTD9DPMYmdD4DM1vm5AexE0Cw+?=
 =?us-ascii?Q?49bkok7k7GtcgHIAV4lXB2rraFD8Rf7itkr9GPrRlJrMMmpCz5Si896y0yHb?=
 =?us-ascii?Q?+ZqBWcIm4lGaEhJigtm5/N78ygY72WT0VWHO467sClFKssK3/YKONmKCE8qN?=
 =?us-ascii?Q?mdD13TKT8FLdNG6f+614AiP9pO9/xh2lzBKzlAvgBgPncfaPLE2RyzNrbD/d?=
 =?us-ascii?Q?oEffwIuiHJA0HDh1embob8IhTk0hO+7sHNy/rpvdzdNtOuJWokFIBKOjpZJ3?=
 =?us-ascii?Q?triCMUFd2/XuvyaKMUKDxlYvxmWsbRfUBXuhena71RFX3cJ3UNcT/BFeNoo/?=
 =?us-ascii?Q?+laXWyGVcq81ivAH/PLs7VmHZjXXF9fMh3OR1KCDhGtk54OPWwoZCbVdXPgc?=
 =?us-ascii?Q?EuhyMyIhZV/xyhDCXjyuBr/fPY2wnUsklby50qjYTn2H+56lwJ8aK4HVBJsj?=
 =?us-ascii?Q?OMl/lJ4OAquVUDD2leAr5t/nCU6zRH+Y2wdaH8Zim+wVQNeMOLj/scskyPp7?=
 =?us-ascii?Q?vml6ZSbnL/jGESNlGD6JMq8I4W6NPmYl5p0qXZ+WQMOeTo8q648KNAr7EGLq?=
 =?us-ascii?Q?+vjAdaSDny26Oz1bKbv6tbnxIEHKbzDx8QgGZd7AvKsVmT2C2gHlMQB38gDS?=
 =?us-ascii?Q?D9d35bs0a9xDdEYKv7/EIBb1b49UPlJ5b2tpwt2sHl4BE1vqbJzS7SpMYc0E?=
 =?us-ascii?Q?k8GV4THB1S6MbQNW5ChHMUIy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a530821-f2b7-42d6-6fc5-08d96bceb0ff
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4133.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2021 15:56:12.9727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sp7INwti4AJ4mw/lrUQHRegQp2Z2zhWNi3E2wKm/W2jAHF9VfrwlCNoz9+ThItajVxNPSrD5IP6VU04PcoenOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 27, 2021 at 04:15:14PM +0200, Borislav Petkov wrote:
> On Fri, Aug 20, 2021 at 10:19:25AM -0500, Brijesh Singh wrote:
> > From: Michael Roth <michael.roth@amd.com>
> > 
> > When the Confidential Computing blob is located by the boot/compressed
> > kernel, store a pointer to it in bootparams->cc_blob_address to avoid
> > the need for the run-time kernel to rescan the EFI config table to find
> > it again.
> > 
> > Since this function is also shared by the run-time kernel, this patch
> 
> Here's "this patch" again... but you know what to do.
> 
> > also adds the logic to make use of bootparams->cc_blob_address when it
> > has been initialized.
> > 
> > Signed-off-by: Michael Roth <michael.roth@amd.com>
> > Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> > ---
> >  arch/x86/kernel/sev-shared.c | 40 ++++++++++++++++++++++++++----------
> >  1 file changed, 29 insertions(+), 11 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
> > index 651980ddbd65..6f70ba293c5e 100644
> > --- a/arch/x86/kernel/sev-shared.c
> > +++ b/arch/x86/kernel/sev-shared.c
> > @@ -868,7 +868,6 @@ static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
> >  	return ES_OK;
> >  }
> >  
> > -#ifdef BOOT_COMPRESSED
> >  static struct setup_data *get_cc_setup_data(struct boot_params *bp)
> >  {
> >  	struct setup_data *hdr = (struct setup_data *)bp->hdr.setup_data;
> > @@ -888,6 +887,16 @@ static struct setup_data *get_cc_setup_data(struct boot_params *bp)
> >   *   1) Search for CC blob in the following order/precedence:
> >   *      - via linux boot protocol / setup_data entry
> >   *      - via EFI configuration table
> > + *   2) If found, initialize boot_params->cc_blob_address to point to the
> > + *      blob so that uncompressed kernel can easily access it during very
> > + *      early boot without the need to re-parse EFI config table
> > + *   3) Return a pointer to the CC blob, NULL otherwise.
> > + *
> > + * For run-time/uncompressed kernel:
> > + *
> > + *   1) Search for CC blob in the following order/precedence:
> > + *      - via linux boot protocol / setup_data entry
> 
> Why would you do this again if the boot/compressed kernel has already
> searched for it?

In some cases it's possible to boot directly to kernel proper without
going through decompression kernel (e.g. CONFIG_PVH), so this is to allow
a way for boot loaders of this sort to provide a CC blob without relying
on EFI. It could be relevant for things like fast/virtualized containers.

> 
> > + *      - via boot_params->cc_blob_address
> 
> Yes, that is the only thing you need to do in the runtime kernel - see
> if cc_blob_address is not 0. And all the work has been done by the
> decompressor kernel already.
> 
> >   *   2) Return a pointer to the CC blob, NULL otherwise.
> >   */
> >  static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
> > @@ -897,9 +906,11 @@ static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
> >  		struct setup_data header;
> >  		u32 cc_blob_address;
> >  	} *sd;
> > +#ifdef __BOOT_COMPRESSED
> >  	unsigned long conf_table_pa;
> >  	unsigned int conf_table_len;
> >  	bool efi_64;
> > +#endif
> 
> That function turns into an unreadable mess with that #ifdef
> __BOOT_COMPRESSED slapped everywhere.
> 
> It seems the cleanest thing to do is to do what we do with
> acpi_rsdp_addr: do all the parsing in boot/compressed/ and pass it on
> through boot_params. Kernel proper simply reads the pointer.
> 
> Which means, you can stick all that cc_blob figuring out functionality
> in arch/x86/boot/compressed/sev.c instead.

Most of the #ifdef'ery is due to the EFI scan, so I moved that part out
to a separate helper, snp_probe_cc_blob_efi(), that lives in
boot/compressed.sev.c. Still not pretty, but would this be acceptable?

/*
 * For boot/compressed kernel:
 *
 *   1) Search for CC blob in the following order/precedence:
 *      - via linux boot protocol / setup_data entry
 *      - via EFI configuration table
 *   2) If found, initialize boot_params->cc_blob_address to point to the
 *      blob so that uncompressed kernel can easily access it during very
 *      early boot without the need to re-parse EFI config table
 *   3) Return a pointer to the CC blob, NULL otherwise.
 *
 * For run-time/uncompressed kernel:
 *
 *   1) Search for CC blob in the following order/precedence:
 *      - via boot_params->cc_blob_address
 *      - via linux boot protocol / setup_data entry
 *   2) Return a pointer to the CC blob, NULL otherwise.
 */
static struct cc_blob_sev_info *sev_snp_probe_cc_blob(struct boot_params *bp)
{
        struct cc_blob_sev_info *cc_info = NULL;
        struct cc_setup_data *sd;

#ifndef __BOOT_COMPRESSED
        /*
         * CC blob isn't in setup_data, see if boot kernel passed it via
         * boot_params.
         */
        if (bp->cc_blob_address) {
                cc_info = (struct cc_blob_sev_info *)(unsigned long)bp->cc_blob_address;
                goto out_verify;
        }
#endif

        /* Try to get CC blob via setup_data */
        sd = get_cc_setup_data(bp);
        if (sd) {
                cc_info = (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
                goto out_verify;
        }

#ifdef __BOOT_COMPRESSED
        cc_info = snp_probe_cc_blob_efi(bp);
#endif

out_verify:
        /* CC blob should be either valid or not present. Fail otherwise. */
        if (cc_info && cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
                sev_es_terminate(1, GHCB_SNP_UNSUPPORTED);

#ifdef __BOOT_COMPRESSED
        /*
         * Pass run-time kernel a pointer to CC info via boot_params for easier
         * access during early boot.
         */
        bp->cc_blob_address = (u32)(unsigned long)cc_info;
#endif

        return cc_info;
}

> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7Cmichael.roth%40amd.com%7C1c87c1e207d64d80bae308d9696503b4%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637656704870745741%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=R3pm8Xf3f5B%2Fm7IDpL%2BiFS0kUdCMmUlhtJFXCROh4YA%3D&amp;reserved=0
