Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0119D30EFAE
	for <lists+linux-efi@lfdr.de>; Thu,  4 Feb 2021 10:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233705AbhBDJ2V (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Feb 2021 04:28:21 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:52821 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233597AbhBDJ2T (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Feb 2021 04:28:19 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1l7avF-000rbJ-Ot; Thu, 04 Feb 2021 10:27:33 +0100
Received: from p5b13a4ea.dip0.t-ipconnect.de ([91.19.164.234] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1l7avF-000ykg-HD; Thu, 04 Feb 2021 10:27:33 +0100
Subject: Re: [PATCH] efi: ia64: move IA64-only declarations to new asm/efi.h
 header
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>, linux-ia64@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Arnd Bergmann <arnd@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
References: <20210118124913.1555-1-ardb@kernel.org>
 <f32b7560-4de4-79bb-a2e2-4edcb2a9d475@physik.fu-berlin.de>
 <CAMj1kXGMzrrEnNfv-cf+fG3snSMDuud48tX1pEZKst9jODkiQw@mail.gmail.com>
 <294348ae-c87a-3bc1-3593-e0c7982fe7d7@physik.fu-berlin.de>
 <CAMj1kXEOR5d7Hva7_=RkaoZw9A3ZBe-6otAL-C9YvL7FHe9+NQ@mail.gmail.com>
 <f8252e56-41ab-e89d-93bf-972cf0bc100b@physik.fu-berlin.de>
 <CAMj1kXEDTLHyECC3yrfQ6Hgw1m9NB1GnNB=dO229To-goE6vmw@mail.gmail.com>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <97279a68-8244-fc7b-87ae-2b9ea0b362e7@physik.fu-berlin.de>
Date:   Thu, 4 Feb 2021 10:27:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAMj1kXEDTLHyECC3yrfQ6Hgw1m9NB1GnNB=dO229To-goE6vmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 91.19.164.234
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 2/4/21 10:22 AM, Ard Biesheuvel wrote:
> Thanks John.
> 
> Would you mind if I cc you in the future on EFI patches that may affect IA-64?

Not at all, please go ahead. I'm happy to test as much as I can.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

