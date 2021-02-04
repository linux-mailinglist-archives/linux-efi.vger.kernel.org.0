Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B490B30EE58
	for <lists+linux-efi@lfdr.de>; Thu,  4 Feb 2021 09:30:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234944AbhBDI1W (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Feb 2021 03:27:22 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:53517 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234966AbhBDI1W (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Feb 2021 03:27:22 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l7ZyJ-000OKz-IK; Thu, 04 Feb 2021 09:26:39 +0100
Received: from p5b13a4ea.dip0.t-ipconnect.de ([91.19.164.234] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l7ZyJ-000qT0-Bu; Thu, 04 Feb 2021 09:26:39 +0100
Subject: Re: [PATCH] efi: ia64: move IA64-only declarations to new asm/efi.h
 header
To:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Cc:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
References: <20210118124913.1555-1-ardb@kernel.org>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <f32b7560-4de4-79bb-a2e2-4edcb2a9d475@physik.fu-berlin.de>
Date:   Thu, 4 Feb 2021 09:26:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210118124913.1555-1-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.234
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard!

On 1/18/21 1:49 PM, Ard Biesheuvel wrote:
> Move some EFI related declarations that are only referenced on IA64 to
> a new asm/efi.h arch header.

I will test these changes later this week. I guess they will make it easier
to drop ia64 support from the kernel if that gets decided in the foreseeable
future.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

