Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8F1A76D3F2
	for <lists+linux-efi@lfdr.de>; Wed,  2 Aug 2023 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjHBQqL (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 2 Aug 2023 12:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjHBQqK (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 2 Aug 2023 12:46:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63018273A;
        Wed,  2 Aug 2023 09:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690994769; x=1722530769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RrRdBl2qy7E3l7kO+e4ZQVEOkVwYkIaDQc+CdA7Vt9A=;
  b=nQHeBRUOvBh3PgvU3zbFFpKZu6HfsD8ySpcYDEg9tl30QRKhyFDprTqU
   rnAK3tdgMXcsGFrLixjLF1xKPEsKyEtLk/X5Cg95BWqyR+He4MaBR3Hhx
   fgkWKTyV3JEJi1yzr2Ud4kpK5ia4KYuEXQtto3Wfk+xithxqeBnZQKukK
   xH4YbwIwJ/GvWQK+THBe+eikOgEaaxc/NZLetiWNRLZKoZQQKfHl1rZ1H
   0L+UIT/m0T2ixnjhsEJ30xmGIOP+Sm7K9dx89JYwuGWhAwI8VrjFPM6Fd
   mX7q3pqNR+SdHRZbxz0fb1bL0MgTVdh/4kmuDk2ZNIzQFOUW5J+MI0hLW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="369644791"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="369644791"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 09:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="732451876"
X-IronPort-AV: E=Sophos;i="6.01,249,1684825200"; 
   d="scan'208";a="732451876"
Received: from dustindi-mobl2.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.37.50])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 09:46:06 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 1B89110A112; Wed,  2 Aug 2023 19:46:03 +0300 (+03)
Date:   Wed, 2 Aug 2023 19:46:03 +0300
From:   "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v2] efi/x86: Ensure that EFI_RUNTIME_MAP is enabled for
 kexec
Message-ID: <20230802164603.fzy2lmflp4iann5c@box>
References: <20230802151704.2147028-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802151704.2147028-1-ardb@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 02, 2023 at 05:17:04PM +0200, Ard Biesheuvel wrote:
> CONFIG_EFI_RUNTIME_MAP needs to be enabled in order for kexec to be able
> to provide the required information about the EFI runtime mappings to
> the incoming kernel, regardless of whether kexec_load() or
> kexec_file_load() is being used. Without this information, kexec boot in
> EFI mode is not possible.
> 
> The CONFIG_EFI_RUNTIME_MAP option is currently directly configurable if
> CONFIG_EXPERT is enabled, so that it can be turned on for debugging
> purposes even if KEXEC is. However, the upshot of this is that it can

s/is/isn't/ ?

> also be disabled even when it shouldn't.
> 
> So tweak the Kconfig declarations to avoid this situation.
> 
> Reported-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Tested-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
