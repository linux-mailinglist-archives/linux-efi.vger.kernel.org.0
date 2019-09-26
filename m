Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22C9FBF625
	for <lists+linux-efi@lfdr.de>; Thu, 26 Sep 2019 17:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbfIZPrD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 26 Sep 2019 11:47:03 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:59657 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727216AbfIZPrD (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 26 Sep 2019 11:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1569512823;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=3aEwo6JJfbDUgaCgNpotaiHPkAU4MWNsC5RaS7WzFvs=;
  b=SbxAXqTHuKjDqjPB/c64CqLeJXxQW0DdT7b559yJQPV7vhK0baiFtGJl
   J5Q6HrhnI+iYVXq9LIOK0uhhQjxskmOQpPZ5uwSoI9XTFii5Dnbe1xxz2
   esZGQg+BDhcGci2yLapQqMpjuAyyKSgHUyoL7v25CJdVHtC+Whps+sEZw
   c=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=ross.lagerwall@citrix.com; spf=Pass smtp.mailfrom=ross.lagerwall@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  ross.lagerwall@citrix.com) identity=pra;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="ross.lagerwall@citrix.com";
  x-sender="ross.lagerwall@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  ross.lagerwall@citrix.com designates 162.221.158.21 as
  permitted sender) identity=mailfrom;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="ross.lagerwall@citrix.com";
  x-sender="ross.lagerwall@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="ross.lagerwall@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: 6lxzUjXZlAuKPwEHzmMyxf4qADNk9nFCa+NImrWQF2kL1Zz0YzyZ+HLgRKwiyGbxBPtSrAm0oR
 hgdZYJTDGBbexISF+AZLYGuk4Ws1MmqSmWMI2vJHIDA2Qly5YG8UZFm9SotEJqd2H4R6NDhVOq
 XYfVifuuHjQjgAxuEykiZojNYDiYbD2hnel7M1X5U/TWS6xxUxuXJauaPGwvNWAZixGGUoPevL
 ItIGM1Kx1gLKKlts6XG9xn+jePp+8tS95XDYkC7Xb01RyukYX72PwiIs0o0033xHtnju+UYxEO
 reU=
X-SBRS: 2.7
X-MesageID: 6356222
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,552,1559534400"; 
   d="scan'208";a="6356222"
Subject: Re: [PATCH] x86/efi: Don't require non-blocking EFI callbacks
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
CC:     linux-efi <linux-efi@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sai Praneeth <sai.praneeth.prakhya@intel.com>
References: <20190926141234.8271-1-ross.lagerwall@citrix.com>
 <CAKv+Gu8ok=v6WaKWW1AmhPgf1-n7p=4h8Tkno9YNW6H8p4fg8w@mail.gmail.com>
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
Message-ID: <be816ae1-b802-f477-20d0-16e5be15a2b8@citrix.com>
Date:   Thu, 26 Sep 2019 16:46:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAKv+Gu8ok=v6WaKWW1AmhPgf1-n7p=4h8Tkno9YNW6H8p4fg8w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 9/26/19 4:29 PM, Ard Biesheuvel wrote:
> On Thu, 26 Sep 2019 at 16:12, Ross Lagerwall <ross.lagerwall@citrix.com> wrote:
>>
>> If a backend does not implement non-blocking EFI operations, it implies
>> that the normal operations are non-blocking.
> 
> Is that documented anywhere?

Sort of. From commit 6d80dba1c9fe "efi: Provide a non-blocking 
SetVariable() operation"

"""
Introduce ->set_variable_nonblocking() for this use case. It is an
optional EFI backend operation, and need only be implemented by those
backends that usually acquire locks to serialize access to EFI
variables, as is the case for virt_efi_set_variable() where we now grab
the EFI runtime spinlock.
"""

> 
>> Instead of crashing
>> dereferencing a NULL pointer, fallback to the normal operations since it
>> is safe to do so.
>>
> 
> I agree that crashing is never the right thing to do, but I wonder
> whether we shouldn't just bail instead. If the provided default
> operation is non-blocking, the platform can populate the function
> pointer with a reference to the default implementation.

If you would prefer it that platforms are always required to implement 
the non-blocking functions, then I will just send a simple patch fixing 
up the Xen implementation.

Thanks,
-- 
Ross Lagerwall
