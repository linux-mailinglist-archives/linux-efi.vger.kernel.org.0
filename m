Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6ADB43A99
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2019 17:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731982AbfFMPWX (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jun 2019 11:22:23 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39021 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731981AbfFMMkx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jun 2019 08:40:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id i125so12596618qkd.6;
        Thu, 13 Jun 2019 05:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W4CLAIpeJG06PjCbzsvwamFdGAAxmhkCmW4gQXkIrJw=;
        b=YQy0fiZoLELAKrhSCZI9hN4RolQ3mGr9GW0aLk1VWo90FBmIwcd7Xh6hD60tsJE8a3
         vPFXn6q7tUjsJqY74TiLVpWlhNDcgRnpmay8jgunVDGiuhwCL4oljVCO9ojRzmK+L8RT
         o601bEDcYetPfXsuDmjpiQbwqN2YXIsZaHHaCb7ZpXOjoCp/y4ilH25mDIPMb6DmXn16
         Qf73KnBS1/Ulp5VhWDJWQn7Mv3CE6j2WqZensSDYcVGPINA4UJNALPn5FNUPh1KlUhhg
         O5Bbb05V++1Z4c1hngZw9qui4V1HWO2DlTnOPktv+f8rx1htmb9qIkyG82tvbbgF4FFd
         dHUg==
X-Gm-Message-State: APjAAAVGEu3Hvs0IYDEHDW2kBQSCHTT8OUKIue1ZjRIWg3NFjzPVBocY
        h0vcgc8zc2b10oEch6eeBmqnPj+UiWsXK1hgz1k=
X-Google-Smtp-Source: APXvYqwGU99G9jdzilaGcV1fsj7pSFIbMEXUh/NygMX9L90OlJJ7BOyG2WVH7aqy/VJ8G1E9zA+MUp00Ps19VL4U6bk=
X-Received: by 2002:a37:a4d3:: with SMTP id n202mr68904510qke.84.1560429652313;
 Thu, 13 Jun 2019 05:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190611125904.1013-1-cai@lca.pw> <CAK8P3a1rK79aj38H0i9vnzeycv6YZ0iUhBFz4giAFc7COTnmWQ@mail.gmail.com>
 <CABLO=+kZnpBm8W9MmSkSf=18R5fLMFe65+_YWw1-of46B+B1dA@mail.gmail.com>
In-Reply-To: <CABLO=+kZnpBm8W9MmSkSf=18R5fLMFe65+_YWw1-of46B+B1dA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Jun 2019 14:40:35 +0200
Message-ID: <CAK8P3a1xhaxBc+N=VXRDZyjUQ+W+=fkeDTUcZqeorsyDCTewZg@mail.gmail.com>
Subject: Re: [PATCH -next] efi/tpm: fix a compilation warning
To:     Bartosz Szczepanek <bsz@semihalf.com>
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

On Thu, Jun 13, 2019 at 1:41 PM Bartosz Szczepanek <bsz@semihalf.com> wrote:
>
> On Thu, Jun 13, 2019 at 10:55 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > - efi.tpm_final_log is a physical address that gets passed into
> >   memremap() to return a pointer
> > - tpm2_calc_event_log_size() takes a pointer argument and
> >   dereferences it.
>
> Where does it? It's passed with some added offset to
> __calc_tpm2_event_size, which does the remapping part. That's why
> physical address is used here.

Ah, right. I was confused by how __calc_tpm2_event_size()
may or may not do the mapping again based on the 'bool do_mapping'
argument, which is 'true' here.

Would it be correct to change that to 'false' then (or completely remove
the additional remap, given that the other two callers pass false
already) and pass final_tbl?

         Arnd
