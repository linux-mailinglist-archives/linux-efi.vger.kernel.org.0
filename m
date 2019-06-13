Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3116439C7
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2019 17:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbfFMPQM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jun 2019 11:16:12 -0400
Received: from mail-vs1-f51.google.com ([209.85.217.51]:46521 "EHLO
        mail-vs1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732210AbfFMNXx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jun 2019 09:23:53 -0400
Received: by mail-vs1-f51.google.com with SMTP id l125so12572843vsl.13
        for <linux-efi@vger.kernel.org>; Thu, 13 Jun 2019 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IpdX1rIhn/1Lk8TZ4g/8IVbNpyTArq72nZxCv7jiCEo=;
        b=iCcOgYbWClI74T8LsWilhPOboTshwxc7nWtBvvK8Z7ywJ/r+FATaJHnGW4MyMnvh4y
         jUk7j+7+CY44jsMrY3m5tGIRuT67dJ6MwiEBmUW2puE+7W8OGkW6NyYnJjz8Wfu57MF9
         tr5iFsez+1s52JVknUcrrcublDgoBc03Sv0dTTzYZMicYz6pQjqYUb82KCRNuG9SRLtl
         2RSzBD+X98xoNhqjtPtg/L4mDXicIA6OpG3eJwUST9rSNzXbmMyWUp6pNf0wiZvKnwW2
         DvxHyhE6zon70y/pcwFSJAFmGr/DEXc5Zp7XyutonkaJmcBVo1bJp1otzRo6lOT0Qrwm
         6izA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IpdX1rIhn/1Lk8TZ4g/8IVbNpyTArq72nZxCv7jiCEo=;
        b=GYsJQUv454HZP6ygSqDln29nK+3exOlEjvzK6KPVW11v+AHm/I28lwywMX61pk7Bf9
         j31z40pYHCUV2g1ILAhFwfqRkM7CiPzOAkJM5kB/N1+EoMUJUrEvrVAAejl39N+KHiy4
         3vjMKnP5Pbhh59BQtFvjmbBcXbZhEMRExLUNBAWn+rr2L0ZbpHSG+yaiuj9HObbJR8By
         gSvTYOGkrxsPyXa8hL2ZprHcZjM1xfp2Z6ZkQCsz4GSY0JMC662nPGqg3oxTKUhnlQ+r
         pj2P1L+CdFPBBvyvsGo/cB3hyMZhI6JoOZwzth4Ya13UIS0muI0VhvLG5QVHYZ9m5mcP
         sl4g==
X-Gm-Message-State: APjAAAWtqXsT4bxqdc+eBqLkEETKiSheyjqfXUvULUZopXfJd7+950QZ
        oigzUVU5ViFiLP6qI39lZ7YuI5BZOWf8jP2zO427Mg==
X-Google-Smtp-Source: APXvYqwN8czoMioCoFYKKJ0HxRg3Skkt2+83tzAgsp1qG20DYQ44UvNFXUtP89dTXn1ua69Avn0x1vk4+P+YzCnp5ek=
X-Received: by 2002:a67:f795:: with SMTP id j21mr996812vso.226.1560432232846;
 Thu, 13 Jun 2019 06:23:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190611125904.1013-1-cai@lca.pw> <CAK8P3a1rK79aj38H0i9vnzeycv6YZ0iUhBFz4giAFc7COTnmWQ@mail.gmail.com>
 <CABLO=+kZnpBm8W9MmSkSf=18R5fLMFe65+_YWw1-of46B+B1dA@mail.gmail.com> <CAK8P3a1xhaxBc+N=VXRDZyjUQ+W+=fkeDTUcZqeorsyDCTewZg@mail.gmail.com>
In-Reply-To: <CAK8P3a1xhaxBc+N=VXRDZyjUQ+W+=fkeDTUcZqeorsyDCTewZg@mail.gmail.com>
From:   Bartosz Szczepanek <bsz@semihalf.com>
Date:   Thu, 13 Jun 2019 15:23:42 +0200
Message-ID: <CABLO=+kNiyLZ5gcSLwGtrXPpnWjutLpaAgE8D0rWGLmkJ15PtA@mail.gmail.com>
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

On Thu, Jun 13, 2019 at 2:40 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Would it be correct to change that to 'false' then (or completely remove
> the additional remap, given that the other two callers pass false
> already) and pass final_tbl?

The problem is that we don't know the final_tbl size before running
tpm2_calc_event_log_size on it, so we cannot map it's entire content.
Only table header is mapped at the beginning.

After size of entire table is calculated it can be mapped as a whole
and no additional remap is needed, hence the calls with do_mapping =
false.
