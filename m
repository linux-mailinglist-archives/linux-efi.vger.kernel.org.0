Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A29B23318
	for <lists+linux-efi@lfdr.de>; Mon, 20 May 2019 13:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731474AbfETL4k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 20 May 2019 07:56:40 -0400
Received: from mga09.intel.com ([134.134.136.24]:39234 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730679AbfETL4k (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Mon, 20 May 2019 07:56:40 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 May 2019 04:56:39 -0700
X-ExtLoop1: 1
Received: from mhauser-mobl.ger.corp.intel.com (HELO localhost) ([10.252.47.244])
  by orsmga002.jf.intel.com with ESMTP; 20 May 2019 04:56:36 -0700
Date:   Mon, 20 May 2019 14:56:34 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org, mingo@kernel.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Matthew Garrett <matthewgarrett@google.com>
Subject: Re: [PATCH] x86/boot: provide KASAN compatible aliases for string
 routines
Message-ID: <20190520115634.GF27805@linux.intel.com>
References: <20190518161113.27780-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190518161113.27780-1-ard.biesheuvel@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, May 18, 2019 at 06:11:13PM +0200, Ard Biesheuvel wrote:
> The KASAN subsystem wraps calls to memcpy(), memset() and memmove()
> to sanitize the arguments before invoking the actual routines, which
> have been renamed to __memcpy(), __memset() and __memmove(),
> respectively. When CONFIG_KASAN is enabled for the kernel build but
> KASAN code generation is disabled for the compilation unit (which is
> needed for things like the EFI stub or the decompressor), the string
> routines are just #define'd to their __ prefixed names so that they
> are simply invoked directly.
> 
> This does however rely on those __ prefixed names to exist in the
> symbol namespace, which is not currently the case for the x86
> decompressor, which may lead to errors like
> 
>   drivers/firmware/efi/libstub/tpm.o: In function `efi_retrieve_tpm2_eventlog':
>   tpm.c:(.text+0x2a8): undefined reference to `__memcpy'
> 
> So let's expose the __ prefixed symbols in the decompressor when
> KASAN is enabled.
> 
> Cc: Andrey Konovalov <andreyknvl@google.com>
> Cc: Matthew Garrett <matthewgarrett@google.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>

/Jarkko
