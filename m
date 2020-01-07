Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16BEE133034
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 21:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgAGUAw (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 15:00:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43945 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728358AbgAGUAw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 15:00:52 -0500
Received: by mail-qk1-f194.google.com with SMTP id t129so517157qke.10
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 12:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Jzy/pg0JfocfwEqBeH4CI1XSgNiVS+eHVqP3Hc/Wg4k=;
        b=K2iunqi5OOiqmcOlXPiS9qezIkuJMVGMWj1HxHX/Tl7fW+BnlBcAPIIizHeJXrQRpf
         XTNdtGhOK0tG50xENl9ZYAh8cZoHRboyFtP01+S6yRdP+ELXzzjrYgY/hAEQJxkRzIMK
         pKVwuyaa7dWHNwT/YS57UgeUNYEWhS7ALtsr20onzCfsDAUJDeflopTkyxRL8ERT5P9g
         +5qKqv0nGWzGiNLDqI2SWrjlIwQUNWI22Vorqaen9fbGc2WYkeuM3O/e9bC5pKvs7Z8V
         lEbVOw2I74DazU9beeIx05TxjRCtgmcUXcltbCB+PdPSFcO4txFx3sjrNcJkc4hQYG65
         5ApQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jzy/pg0JfocfwEqBeH4CI1XSgNiVS+eHVqP3Hc/Wg4k=;
        b=G8y6J4A+p9sussb96EuQo21bCBYE+B/xA97nJ0MmvnOiwQYETmKwxbOfo2/gTUY3GD
         MCRxd3o+icelIuAdIWyNHI9/XR3hp0rm4EV7CM0FLpI1gXfRq2Q2eYWeCKuqZMcc8B2j
         8FfUfOS/Lig0aSuy+TBblrZieciZVoD8+lAI29li5nSAekQM0KVjILHAEyfjD7aQxVtN
         zN4VISXlvBz5pOfWo3JlEU622PAUc4QMuhfPV1AmSChUbKGbR3P6ZNimhFN0OANIRI4L
         +suLP4+QSAGOqP9v5bWuFIAwY8IBgxaiWh1jmMXQkmLLV0hjw7w/aAv/QbWkr9k80oEx
         RgQw==
X-Gm-Message-State: APjAAAX6WOpeyd8gDutYYujCaxEw4SydN0k0NU6ArAIbasebS9QL1vv+
        ct0UCU4GGAYNUvLKfRLEGN0=
X-Google-Smtp-Source: APXvYqxmH9cE1oTEIMePOSdr+tHfO3cuzOoH3+cbyYTIguv6vK8qOsefhzgh6g5ZqmzUxAxr7Zf62Q==
X-Received: by 2002:a37:52d5:: with SMTP id g204mr1034798qkb.215.1578427251435;
        Tue, 07 Jan 2020 12:00:51 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g81sm315459qkb.70.2020.01.07.12.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 12:00:51 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 7 Jan 2020 15:00:49 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
Message-ID: <20200107200049.GA2172504@rani.riverdale.lan>
References: <CAKv+Gu8v-5DXWh5ZaY0omrVNh46TEourpcf2Hv3TrsbCUtLFng@mail.gmail.com>
 <20200107175829.GA1599060@rani.riverdale.lan>
 <CAKv+Gu-PU=LqT7MEbSH-0GnJOdakDeaC=ANdmag6JptcfJEJtA@mail.gmail.com>
 <20200107180807.GA1642410@rani.riverdale.lan>
 <CAKv+Gu8Jsen-oAvUYrrTXnLRog+iHsLf0s6EMJ9smgUXpzncZw@mail.gmail.com>
 <20200107183224.GB1642410@rani.riverdale.lan>
 <CAKv+Gu_+8-vFFg6V06cxK4McbqOeqkAFYGB_MHDU3jcFyM1yHA@mail.gmail.com>
 <20200107191412.GA1685286@rani.riverdale.lan>
 <CAKv+Gu8CsQOZJErDOjCtMB-6yr92CmLiCFpOTeoqdZWBOLh1oQ@mail.gmail.com>
 <CAKv+Gu97YJ5AiG0+38fGJWfr6DWsohLrpUxGfdqaRawEhqbhTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu97YJ5AiG0+38fGJWfr6DWsohLrpUxGfdqaRawEhqbhTw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 07, 2020 at 08:51:14PM +0100, Ard Biesheuvel wrote:
> >
> > Yeah. I have just reinstalled Ubuntu Trusty in a VM, which has
> > binutils 2.4 and has a GCC 4.6 package available, but I haven't tried
> > building the 64-bit kernel yet.
> >
> 
> I see the same thing: all GOT entries are gone when using -include to
> set the pragma, with the exception of the first 0x18 bytes of the
> .got.plt section, which we can ignore.
> 
> So in summary, we should be able ASSERT() in the linker script that
> (_egot - _got) <= 3 * word size, and get rid of all the GOT fixup code
> entirely. Or perhaps it is better to add a section marker, and assert
> that the *(.got) part is really empty.

Great!
