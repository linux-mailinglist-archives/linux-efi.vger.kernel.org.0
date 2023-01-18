Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE99E67218D
	for <lists+linux-efi@lfdr.de>; Wed, 18 Jan 2023 16:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjARPl4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Jan 2023 10:41:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjARPlx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Jan 2023 10:41:53 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F67112596;
        Wed, 18 Jan 2023 07:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674056512; x=1705592512;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oDbeD+94j2sqIaSf3nZfHg8M7FyaDfrDoJHJdLgJFy8=;
  b=nhdHuPRMsyZFez6Qtnuu1/LECYRTnsXzmyol10rcP7DGqgZolaHt2Iqu
   5H8ZX9Voyxkaeb6hAF/icLkQag1xXt1n/BGpiDNt2pcW18oOg4vhpi76Y
   TPFsOcz8ssKJpxtKf6//uoE6fpxouNJWgQo3HKDL9f8/mnSxm1Mt4+gdL
   UK61phUk/qGF3r+KKq/CC4wLZPL99rgsqUjiv99SzNe0aRZwx1MtC2tMV
   rVlnRar4O6E7f1mVZypfBQ9S5b7tP5UpqeTPiKaSOQizoQkkB8Y3euuVq
   hFbJk5EhXUrfT0ZeYdZ1eOevYipU392pzDnPlHaqQiYEvEMoiJuUvJPLS
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="304692977"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="304692977"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 07:39:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="723128703"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="723128703"
Received: from megreen-mobl.amr.corp.intel.com (HELO [10.209.72.115]) ([10.209.72.115])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 07:39:50 -0800
Message-ID: <e1986845-9eb9-2147-5073-5d7a45633aba@intel.com>
Date:   Wed, 18 Jan 2023 07:40:05 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] x86/efi: Safely enable unaccepted memory in UEFI
Content-Language: en-US
To:     Ard Biesheuvel <ardb@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>
Cc:     Gerd Hoffmann <kraxel@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        x86@kernel.org, jiewen.yao@intel.com, devel@edk2.groups.io,
        "Min M. Xu" <min.m.xu@intel.org>,
        James Bottomley <jejb@linux.ibm.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
References: <20230113212926.2904735-1-dionnaglaze@google.com>
 <20230113222024.rp2erl54vx3grdbd@box.shutemov.name>
 <20230116105648.63hsxnmj2juwudmu@sirius.home.kraxel.org>
 <def9b0b5-b880-be99-fa95-b05d76a91824@intel.com>
 <1818a72f-31ef-07b0-d1b4-6a8904636db2@amd.com>
 <CAMj1kXG7s_B1nyEgsxFRRvUzsWNXcFfTszRA2hKY=_a-L24PZg@mail.gmail.com>
From:   Dave Hansen <dave.hansen@intel.com>
In-Reply-To: <CAMj1kXG7s_B1nyEgsxFRRvUzsWNXcFfTszRA2hKY=_a-L24PZg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 1/18/23 07:09, Ard Biesheuvel wrote:
> However, I guess we're at a point where SEV and TDX really want
> different solutions, so I think divergence might be the way to
> proceed.

I don't think they want different things really.

TDX doesn't need this protocol.  It sounds like SEV does need it,
though.  That doesn't mean they really diverge.  They're *both* going to
have to poke at this protocol knob to get the firmware to not accept the
memory.

This does slightly change the motivation for doing explicit unaccepted
memory support in the kernel.

I also don't know _quite_ how this will look to a guest.  For instance,
will they see different memory maps based on which protocol they are
using?  I assume so, but didn't see any of that explicitly mentioned in
this patch.
