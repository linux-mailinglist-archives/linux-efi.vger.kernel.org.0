Return-Path: <linux-efi+bounces-1616-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BFE962E45
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 19:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B4911C23B26
	for <lists+linux-efi@lfdr.de>; Wed, 28 Aug 2024 17:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 692521A7079;
	Wed, 28 Aug 2024 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azHCmxiT"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391C1A706C;
	Wed, 28 Aug 2024 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724865259; cv=none; b=qdbNctNH+buF0EwJMIkLmY0+7uZ0GE0RZrkobrf9lnCiMeU7GhXGT9AHF9D5NVqTC3UsYRG0cNW3lIMeVNIoBpC+CQCCUOHDPbeI9bVyIu0KgfAYOj/MW943LhDXUlXy50SIzs5X1tSPWn6J9vmGHra0eLzqD0/r0ZO/jw0JMEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724865259; c=relaxed/simple;
	bh=JMXcxtayu0gzzaCBWTcXmf2eB/HAKHtp+/XlQYk6MBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TRTAdVmcplpjL+SbRIxBUKo51aCAdWqS3aEZ+PX67vNjTOLo6zj4e7aB/HjEdrn4ilxiDtY/WyUZNDDTR7QL9fhblJtUfSNL8rmPC8KsPXf/jav8dCe/Fs79Vo20ZNv/ZbaTODV7VFpLHFCyIf5PP1SvCLr1Vx8o6wAgj7gph8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azHCmxiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5EFC4AF10;
	Wed, 28 Aug 2024 17:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724865258;
	bh=JMXcxtayu0gzzaCBWTcXmf2eB/HAKHtp+/XlQYk6MBo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=azHCmxiTXKE3x7rwJPOfbJepWeWHKeou6GzC9yWlspuG4haAA3acy6WVh77iaM4z5
	 O2OEFuda+1O6DK77JDqyue3RDMfwcX8207p6iR328o/8iCFuXjPiZeb+JIgV8NOlcs
	 lMlASpeCY07DWlr9IefrQ5mr8lwLYIVSElhKb3L+YVjJ0eNch1k5kT5b39NgeDMQ6m
	 wnqxzfoiN7p2vuIQv8LhOqnhQpNfhEaLIS5uA0nb9odqS6zthIw0K7LuXuSkMirueU
	 Hto6PVWap9ehICcysOfp3iK4wrSz5Wd9tZ+DWn7JRrZ5fOm0dlYbkUW1gOfwO2wnms
	 ruA65lYdzvEAA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-534366c1aa2so6137488e87.1;
        Wed, 28 Aug 2024 10:14:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUFpq7AWRC/zaBOSIuXnWzId9zmXWhEVGCmJD+1k6PZzou+ll54NSIgh45z3qWTchKaiKj+E7WCKwKh@vger.kernel.org, AJvYcCVJxsff5RpUvTVQcPRLiRQ2tdTjP14ZgTq1bFjDfZrP7KITtgX45xnuTWI5Ihn4/IafK5y3vhrLgHXS@vger.kernel.org, AJvYcCVYOSb3/Q6a62+5SxrpdHSTNEI3r2v/fbhhhpi4BO0sJ4a6LbI23nieGa6Y/C9hK+bKJvFQagGDp3GToLmT@vger.kernel.org, AJvYcCWxxDWSFeDrRWRftxIaVzo1LWgrZZECdHOnZ06CdtuzJtVmErYCQ3XFDhU1FR0T/qERTlFZrrOVb+ky4rE=@vger.kernel.org, AJvYcCXvWxuB/chG7GRiSeojp4tkKGJpTXovEaJp/XeFOpk0KrIUvE3U4OV/na6uERmJyl25jRLRHHw+2mW7QxOUptFX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl02PTVlzuxEvCgU+6y7qp7gyPd7JsXDULCIQxTmRKorZlhV68
	5WKoR17Ol12CTxx2pgTMzM34g1Txcoj9zeR8hXcqB9sf9ieLxjxY2rgFVLxqaFSbb6qOghvAHCq
	XbmkQKCU5DfEiUvhq3m00zjFsbpg=
X-Google-Smtp-Source: AGHT+IGjIAEHfnaAvWDGrHZH9ur0Yqdu+2C9S8V61720ewupp4mWfrA47TtZM9rrWmWlkP/s8kuZindCvpyLzRoi8jM=
X-Received: by 2002:a05:6512:3052:b0:52e:9b2f:c313 with SMTP id
 2adb3069b0e04-53438831efbmr11902856e87.22.1724865257121; Wed, 28 Aug 2024
 10:14:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240826223835.3928819-21-ross.philipson@oracle.com> <202408290030.FEbUhHbr-lkp@intel.com>
In-Reply-To: <202408290030.FEbUhHbr-lkp@intel.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 28 Aug 2024 19:14:06 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGVn85ht_srwhYXDnKffPFX=B2+Cnv-8EAocwoHi__OoQ@mail.gmail.com>
Message-ID: <CAMj1kXGVn85ht_srwhYXDnKffPFX=B2+Cnv-8EAocwoHi__OoQ@mail.gmail.com>
Subject: Re: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for
 Secure Launch
To: kernel test robot <lkp@intel.com>
Cc: Ross Philipson <ross.philipson@oracle.com>, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org, 
	oe-kbuild-all@lists.linux.dev, dpsmith@apertussolutions.com, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com, 
	dave.hansen@linux.intel.com, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, jarkko@kernel.org, 
	jgg@ziepe.ca, luto@amacapital.net, nivedita@alum.mit.edu, 
	herbert@gondor.apana.org.au, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 28 Aug 2024 at 19:09, kernel test robot <lkp@intel.com> wrote:
>
> Hi Ross,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on tip/x86/core]
> [also build test WARNING on char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master efi/next linus/master v6.11-rc5]
> [cannot apply to herbert-crypto-2.6/master next-20240828]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/Documentation-x86-Secure-Launch-kernel-documentation/20240827-065225
> base:   tip/x86/core
> patch link:    https://lore.kernel.org/r/20240826223835.3928819-21-ross.philipson%40oracle.com
> patch subject: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for Secure Launch
> config: i386-randconfig-062-20240828 (https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/config)


This is a i386 32-bit build, which makes no sense: this stuff should
just declare 'depends on 64BIT'


> compiler: clang version 18.1.5 (https://github.com/llvm/llvm-project 617a15a9eac96088ae5e9134248d8236e34b91b1)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202408290030.FEbUhHbr-lkp@intel.com/
>
> sparse warnings: (new ones prefixed by >>)
> >> drivers/firmware/efi/libstub/x86-stub.c:945:41: sparse: sparse: non size-preserving pointer to integer cast
>    drivers/firmware/efi/libstub/x86-stub.c:953:65: sparse: sparse: non size-preserving pointer to integer cast
> >> drivers/firmware/efi/libstub/x86-stub.c:980:70: sparse: sparse: non size-preserving integer to pointer cast
>    drivers/firmware/efi/libstub/x86-stub.c:1014:45: sparse: sparse: non size-preserving integer to pointer cast
>
> vim +945 drivers/firmware/efi/libstub/x86-stub.c
>
>    927
>    928  static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
>    929                                                   struct boot_params *boot_params)
>    930  {
>    931          struct slr_entry_intel_info *txt_info;
>    932          struct slr_entry_policy *policy;
>    933          struct txt_os_mle_data *os_mle;
>    934          bool updated = false;
>    935          int i;
>    936
>    937          txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
>    938          if (!txt_info)
>    939                  return false;
>    940
>    941          os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
>    942          if (!os_mle)
>    943                  return false;
>    944
>  > 945          os_mle->boot_params_addr = (u64)boot_params;
>    946
>    947          policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
>    948          if (!policy)
>    949                  return false;
>    950
>    951          for (i = 0; i < policy->nr_entries; i++) {
>    952                  if (policy->policy_entries[i].entity_type == SLR_ET_BOOT_PARAMS) {
>    953                          policy->policy_entries[i].entity = (u64)boot_params;
>    954                          updated = true;
>    955                          break;
>    956                  }
>    957          }
>    958
>    959          /*
>    960           * If this is a PE entry into EFI stub the mocked up boot params will
>    961           * be missing some of the setup header data needed for the second stage
>    962           * of the Secure Launch boot.
>    963           */
>    964          if (image) {
>    965                  struct setup_header *hdr = (struct setup_header *)((u8 *)image->image_base +
>    966                                              offsetof(struct boot_params, hdr));
>    967                  u64 cmdline_ptr;
>    968
>    969                  boot_params->hdr.setup_sects = hdr->setup_sects;
>    970                  boot_params->hdr.syssize = hdr->syssize;
>    971                  boot_params->hdr.version = hdr->version;
>    972                  boot_params->hdr.loadflags = hdr->loadflags;
>    973                  boot_params->hdr.kernel_alignment = hdr->kernel_alignment;
>    974                  boot_params->hdr.min_alignment = hdr->min_alignment;
>    975                  boot_params->hdr.xloadflags = hdr->xloadflags;
>    976                  boot_params->hdr.init_size = hdr->init_size;
>    977                  boot_params->hdr.kernel_info_offset = hdr->kernel_info_offset;
>    978                  efi_set_u64_form(boot_params->hdr.cmd_line_ptr, boot_params->ext_cmd_line_ptr,
>    979                                   &cmdline_ptr);
>  > 980                  boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
>    981          }
>    982
>    983          return updated;
>    984  }
>    985
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
>

