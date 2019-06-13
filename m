Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 540DC43B37
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2019 17:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727266AbfFMP1F (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jun 2019 11:27:05 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:40747 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729064AbfFMLld (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jun 2019 07:41:33 -0400
Received: by mail-ua1-f68.google.com with SMTP id s4so7175780uad.7
        for <linux-efi@vger.kernel.org>; Thu, 13 Jun 2019 04:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H4VyKD+1E4l8WEL9xPMuwhvlmL4tX+kahUY4NzXzOPg=;
        b=GEPuNeYcY/7A1PQYuYWpQnvhWJkLDdN+G4zM83miDSvxP35U8hvwvgmHn/DZ0jawal
         M6EZ+qGxSyPscR3LXUy3gax36GEgVhXh5uNmFOHWDXVTzw5+JQBr7bSXc3k1BRJCp+Yj
         eAohEXwqZSGCl+pkaevh8cWV8OnN72kHk9QghGe+Ry/zIfeFQhtgnYs9b0ZGXPfIxd1U
         ivRWDapr3eGWpgcnnypxlaGxd0NuLbWsUg9G7NO573oSG1ILxKvuiBzs9LFESq0KXfP/
         aja32Rib05Mnat8HtkFr23HtdsduG5Cp5HpirNXqmkLSTSD0Lpgy1ydq/hJVXkZLfLno
         SipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H4VyKD+1E4l8WEL9xPMuwhvlmL4tX+kahUY4NzXzOPg=;
        b=m0VhPsdD6LAohEV8S6sQOKXJApNrPXnDkWoAZhNcsQp2BSX2j74jnGfZgw4u5vJ0G7
         UYSGOD7OZF9kL1pNncbApjrcLdjuHmtzj29WLq9jsihKnfSRGC0v2mERaXZNZkmEzKZi
         cTF9SEORm66i7etGYUHtZc6xDE76JUjuYroViN+98XspES3RwK6QKTMlO/7Ui4bcxiCG
         HzStDd98dxzP/NjZ4LktO+Ckb81Oaf9hWJc48hTPy8FeI9eJMDipdXjONOyGUYV5tLjZ
         dUSGXvLxv245wx6gXbOeqMsK65zqi8r3MtzUj3YLtq+jzQKmnH/9b6k675kgjwxTadYU
         RY9g==
X-Gm-Message-State: APjAAAV4GVmsw3y4/OZfsw9KcM5kP6skIdJfm3l5akI58nsLZ79kFKk7
        sxydTmwixfQdtT6IxSvk4lhbnJe2u+sngcn4heqNFg==
X-Google-Smtp-Source: APXvYqy0vis982DlAQpR8yglXZ8HB3wfAgsUSmQ72Boq9mcMDBp+XhU8TfZYqGzdegC8IM7YJTPUslblgiRFraos2vI=
X-Received: by 2002:ab0:168a:: with SMTP id e10mr33043256uaf.87.1560426092549;
 Thu, 13 Jun 2019 04:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190611125904.1013-1-cai@lca.pw> <CAK8P3a1rK79aj38H0i9vnzeycv6YZ0iUhBFz4giAFc7COTnmWQ@mail.gmail.com>
In-Reply-To: <CAK8P3a1rK79aj38H0i9vnzeycv6YZ0iUhBFz4giAFc7COTnmWQ@mail.gmail.com>
From:   Bartosz Szczepanek <bsz@semihalf.com>
Date:   Thu, 13 Jun 2019 13:41:21 +0200
Message-ID: <CABLO=+kZnpBm8W9MmSkSf=18R5fLMFe65+_YWw1-of46B+B1dA@mail.gmail.com>
Subject: Re: [PATCH -next] efi/tpm: fix a compilation warning
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Qian Cai <cai@lca.pw>, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Matthew Garrett <mjg59@google.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 13, 2019 at 10:55 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> - efi.tpm_final_log is a physical address that gets passed into
>   memremap() to return a pointer
> - tpm2_calc_event_log_size() takes a pointer argument and
>   dereferences it.

Where does it? It's passed with some added offset to
__calc_tpm2_event_size, which does the remapping part. That's why
physical address is used here.

> My best guess is that we should pass the output of memremap()
> here rather than the input:
>
> --- a/drivers/firmware/efi/tpm.c
> +++ b/drivers/firmware/efi/tpm.c
> @@ -75,7 +75,7 @@ int __init efi_tpm_eventlog_init(void)
>                 goto out;
>         }
>
> -       tbl_size = tpm2_calc_event_log_size(efi.tpm_final_log
> +       tbl_size = tpm2_calc_event_log_size(final_tbl
>                                             + sizeof(final_tbl->version)
>                                             + sizeof(final_tbl->nr_events),
>                                             final_tbl->nr_events,
>
> No idea if that is actually what was intended here, but it makes
> the code look more plausible.

Passing final_tbl will lead to failure, as it will be remapped for
second time. Cast is needed here. Changing the type from void* to
unsigned long or phys_addr_t (and casting later) would also do the
job. I'm fine with both options.
