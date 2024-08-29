Return-Path: <linux-efi+bounces-1624-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C642F964742
	for <lists+linux-efi@lfdr.de>; Thu, 29 Aug 2024 15:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5E3280F07
	for <lists+linux-efi@lfdr.de>; Thu, 29 Aug 2024 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E08D1A76D2;
	Thu, 29 Aug 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=earth.li header.i=@earth.li header.b="SpXzNTJw"
X-Original-To: linux-efi@vger.kernel.org
Received: from the.earth.li (the.earth.li [93.93.131.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67C61AE024;
	Thu, 29 Aug 2024 13:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.93.131.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724939582; cv=none; b=Ua0XUBMVdzwYAV5OaUbmpZWoCIF8G9NAKwEGzHyz9UP7NCgVcIEmv40xTP1AW0dsOXDT0VeCxzednkvvxad2QT4bqgEOTJSsaa8ixvPKl1azLdG9VQQpMqQWVydOuvrtqq3MFnAZfZLuBOTB0Sc2iyEPxSYJjRk5ljDaAoNPMOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724939582; c=relaxed/simple;
	bh=TS8/vjAK45qFX9WJoJ/dilPjrHp5NM1aNV5VZoirYWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AND3lPaOCJqGAgcAi3c4Fez6N2PJebhTl4oMoqiNDegwpXfN1bBoSx2dqtnWW+f6Vo2rqHScUzx6MDPyVSC8tLFdvLAd6Bt51Z5Nfm7svTZkyQFLTFTNQswxW+Jspudlkf2Ri9IkPR8cYym+mKeO4cHHt+MUgsT1gYht/KeJzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li; spf=pass smtp.mailfrom=earth.li; dkim=pass (2048-bit key) header.d=earth.li header.i=@earth.li header.b=SpXzNTJw; arc=none smtp.client-ip=93.93.131.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=earth.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=earth.li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=earth.li;
	s=the; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:
	Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4SsUxAHHD2XiSfMK9a212e44ANeEU+e+fE9aWYn+bJE=; b=SpXzNTJw16lQvy4BiXl4M+gO1C
	X/YJoIDkFgrEqq5d8KnaDYzUPu/62gk0yYm0gxbcTncsHvpJqc9JLwd4JFlqCPah1H+So/oi4HnOg
	dmqJAIZfYwV8dZdQKqDev1dK+qHEsmGi2dKR0ha1UxnwMdi9dA1dCsR7GLquKrGGsZy24oZqVVMZD
	78RtG2CnBczWuj57uGcmkjy7nqpfrR0T2CZBNiSzxCThAftLWAUSz6S/Yq9U+21Fe0DSNYMCZ9n9I
	psZThcU/wEKQ4w5K/cFHaE970E8T/NnaDHK/ncPwoSSz4b41lqdcDOct1rqa7jk9DqW3dl8sGpuww
	prZbRpdw==;
Received: from noodles by the.earth.li with local (Exim 4.96)
	(envelope-from <noodles@earth.li>)
	id 1sjf80-00BZY2-0U;
	Thu, 29 Aug 2024 14:23:56 +0100
Date: Thu, 29 Aug 2024 14:23:56 +0100
From: Jonathan McDowell <noodles@earth.li>
To: ross.philipson@oracle.com
Cc: Ard Biesheuvel <ardb@kernel.org>, kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
	linux-efi@vger.kernel.org, iommu@lists.linux-foundation.org,
	oe-kbuild-all@lists.linux.dev, dpsmith@apertussolutions.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
	dave.hansen@linux.intel.com, mjg59@srcf.ucam.org,
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de,
	jarkko@kernel.org, jgg@ziepe.ca, luto@amacapital.net,
	nivedita@alum.mit.edu, herbert@gondor.apana.org.au,
	davem@davemloft.net, corbet@lwn.net, ebiederm@xmission.com,
	dwmw2@infradead.org, baolu.lu@linux.intel.com,
	kanth.ghatraju@oracle.com
Subject: Re: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for
 Secure Launch
Message-ID: <ZtB2bP1Mx3zTr9e5@earth.li>
References: <20240826223835.3928819-21-ross.philipson@oracle.com>
 <202408290030.FEbUhHbr-lkp@intel.com>
 <CAMj1kXGVn85ht_srwhYXDnKffPFX=B2+Cnv-8EAocwoHi__OoQ@mail.gmail.com>
 <6b214ad2-d448-4f5f-85e9-93cd38e0e035@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b214ad2-d448-4f5f-85e9-93cd38e0e035@oracle.com>

On Wed, Aug 28, 2024 at 01:19:16PM -0700, ross.philipson@oracle.com wrote:
> On 8/28/24 10:14 AM, Ard Biesheuvel wrote:
> > On Wed, 28 Aug 2024 at 19:09, kernel test robot <lkp@intel.com> wrote:
> > > 
> > > Hi Ross,
> > > 
> > > kernel test robot noticed the following build warnings:
> > > 
> > > [auto build test WARNING on tip/x86/core]
> > > [also build test WARNING on char-misc/char-misc-testing char-misc/char-misc-next char-misc/char-misc-linus herbert-cryptodev-2.6/master efi/next linus/master v6.11-rc5]
> > > [cannot apply to herbert-crypto-2.6/master next-20240828]
> > > [If your patch is applied to the wrong git tree, kindly drop us a note.
> > > And when submitting patch, we suggest to use '--base' as documented in
> > > https://urldefense.com/v3/__https://git-scm.com/docs/git-format-patch*_base_tree_information__;Iw!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIxuz-LAC$ ]
> > > 
> > > url:    https://urldefense.com/v3/__https://github.com/intel-lab-lkp/linux/commits/Ross-Philipson/Documentation-x86-Secure-Launch-kernel-documentation/20240827-065225__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI7Z6SQKy$
> > > base:   tip/x86/core
> > > patch link:    https://urldefense.com/v3/__https://lore.kernel.org/r/20240826223835.3928819-21-ross.philipson*40oracle.com__;JQ!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIzWfs1XZ$
> > > patch subject: [PATCH v10 20/20] x86/efi: EFI stub DRTM launch support for Secure Launch
> > > config: i386-randconfig-062-20240828 (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/config__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIwkYG0TY$ )
> > 
> > 
> > This is a i386 32-bit build, which makes no sense: this stuff should
> > just declare 'depends on 64BIT'
> 
> Our config entry already has 'depends on X86_64' which in turn depends on
> 64BIT. I would think that would be enough. Do you think it needs an explicit
> 'depends on 64BIT' in our entry as well?

The error is in x86-stub.c, which is pre-existing and compiled for 32
bit as well, so you need more than a "depends" here.

> > > compiler: clang version 18.1.5 (https://urldefense.com/v3/__https://github.com/llvm/llvm-project__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI2SDLdTN$  617a15a9eac96088ae5e9134248d8236e34b91b1)
> > > reproduce (this is a W=1 build): (https://urldefense.com/v3/__https://download.01.org/0day-ci/archive/20240829/202408290030.FEbUhHbr-lkp@intel.com/reproduce__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI5MJDdIG$ )
> > > 
> > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > the same patch/commit), kindly add following tags
> > > | Reported-by: kernel test robot <lkp@intel.com>
> > > | Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-kbuild-all/202408290030.FEbUhHbr-lkp@intel.com/__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmI-MitiqR$
> > > 
> > > sparse warnings: (new ones prefixed by >>)
> > > > > drivers/firmware/efi/libstub/x86-stub.c:945:41: sparse: sparse: non size-preserving pointer to integer cast
> > >     drivers/firmware/efi/libstub/x86-stub.c:953:65: sparse: sparse: non size-preserving pointer to integer cast
> > > > > drivers/firmware/efi/libstub/x86-stub.c:980:70: sparse: sparse: non size-preserving integer to pointer cast
> > >     drivers/firmware/efi/libstub/x86-stub.c:1014:45: sparse: sparse: non size-preserving integer to pointer cast
> > > 
> > > vim +945 drivers/firmware/efi/libstub/x86-stub.c
> > > 
> > >     927
> > >     928  static bool efi_secure_launch_update_boot_params(struct slr_table *slrt,
> > >     929                                                   struct boot_params *boot_params)
> > >     930  {
> > >     931          struct slr_entry_intel_info *txt_info;
> > >     932          struct slr_entry_policy *policy;
> > >     933          struct txt_os_mle_data *os_mle;
> > >     934          bool updated = false;
> > >     935          int i;
> > >     936
> > >     937          txt_info = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_INTEL_INFO);
> > >     938          if (!txt_info)
> > >     939                  return false;
> > >     940
> > >     941          os_mle = txt_os_mle_data_start((void *)txt_info->txt_heap);
> > >     942          if (!os_mle)
> > >     943                  return false;
> > >     944
> > >   > 945          os_mle->boot_params_addr = (u64)boot_params;
> > >     946
> > >     947          policy = slr_next_entry_by_tag(slrt, NULL, SLR_ENTRY_ENTRY_POLICY);
> > >     948          if (!policy)
> > >     949                  return false;
> > >     950
> > >     951          for (i = 0; i < policy->nr_entries; i++) {
> > >     952                  if (policy->policy_entries[i].entity_type == SLR_ET_BOOT_PARAMS) {
> > >     953                          policy->policy_entries[i].entity = (u64)boot_params;
> > >     954                          updated = true;
> > >     955                          break;
> > >     956                  }
> > >     957          }
> > >     958
> > >     959          /*
> > >     960           * If this is a PE entry into EFI stub the mocked up boot params will
> > >     961           * be missing some of the setup header data needed for the second stage
> > >     962           * of the Secure Launch boot.
> > >     963           */
> > >     964          if (image) {
> > >     965                  struct setup_header *hdr = (struct setup_header *)((u8 *)image->image_base +
> > >     966                                              offsetof(struct boot_params, hdr));
> > >     967                  u64 cmdline_ptr;
> > >     968
> > >     969                  boot_params->hdr.setup_sects = hdr->setup_sects;
> > >     970                  boot_params->hdr.syssize = hdr->syssize;
> > >     971                  boot_params->hdr.version = hdr->version;
> > >     972                  boot_params->hdr.loadflags = hdr->loadflags;
> > >     973                  boot_params->hdr.kernel_alignment = hdr->kernel_alignment;
> > >     974                  boot_params->hdr.min_alignment = hdr->min_alignment;
> > >     975                  boot_params->hdr.xloadflags = hdr->xloadflags;
> > >     976                  boot_params->hdr.init_size = hdr->init_size;
> > >     977                  boot_params->hdr.kernel_info_offset = hdr->kernel_info_offset;
> > >     978                  efi_set_u64_form(boot_params->hdr.cmd_line_ptr, boot_params->ext_cmd_line_ptr,
> > >     979                                   &cmdline_ptr);
> > >   > 980                  boot_params->hdr.cmdline_size = strlen((const char *)cmdline_ptr);
> > >     981          }
> > >     982
> > >     983          return updated;
> > >     984  }
> > >     985
> > > 
> > > --
> > > 0-DAY CI Kernel Test Service
> > > https://urldefense.com/v3/__https://github.com/intel/lkp-tests/wiki__;!!ACWV5N9M2RV99hQ!KhkZK77BXRIR4F24tKkUeIlIrdqXtUW2vcnDV74c_5BmrQBQaQ4FqcDKKv9LB3HQUocTGkrmIy5kGTJf$
> > > 
> 
> 

J.

-- 
   101 things you can't have too   |  .''`.  Debian GNU/Linux Developer
     much of : 23 - Red Dwarf.     | : :' :  Happy to accept PGP signed
                                   | `. `'   or encrypted mail - RSA
                                   |   `-    key on the keyservers.

