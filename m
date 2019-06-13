Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A896E43EF3
	for <lists+linux-efi@lfdr.de>; Thu, 13 Jun 2019 17:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731657AbfFMPyF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Jun 2019 11:54:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44846 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731583AbfFMIzv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Jun 2019 04:55:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id x47so21609711qtk.11;
        Thu, 13 Jun 2019 01:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7PArDXUl7LOBVHDgdyyLrxHdLxjO1IqwghuUIhjgcI=;
        b=d2hn+aLmeC3GeEaXUCxbRm6Xh48sTjGT+zTdVYxP/SpuxyOzTsD6eFLT8i3onuPGVH
         S+oHZLiiY0FWVbHHfxY71k2+8X8wgQMpbPxUBwhivXFHxbv4jYVxKNGlH0cH+lW3uGRE
         VkU1OlRcR5TOaKZRg3oFAI2n9LSV6S2CZlxT+cDsk0tQARhQB90oBdBsFQSXw+tMsZfg
         HWy493u2K/yNlb52sMgGP8fi9hva6oZs57/Ra/me9pPfyyrLJqMNZkalvlWbagK3kqwq
         R6Rf4nLrAKXT7iZzYvP5HjOZnmgo0I+guXW8zmo/p11iwEaORS6udSj5yjyY+80vzyk0
         UZvQ==
X-Gm-Message-State: APjAAAUuuM+/7gyAFr6WKLYUrtWBpJNWII/QKZ3VOG4wkXa4qykH05tj
        PsJq2Tn2FHe0+TctyDgBJBGzx41TPewNwToPd1Q=
X-Google-Smtp-Source: APXvYqyV757/8drEgvHANCu8E4/7UvtAUgKyhza7EAYxf/aJTGFuMfHORa+kSycX7K8zIro0bivSjBR0z6Hb1yOYhpU=
X-Received: by 2002:a0c:8b49:: with SMTP id d9mr2445970qvc.63.1560416149917;
 Thu, 13 Jun 2019 01:55:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190611125904.1013-1-cai@lca.pw>
In-Reply-To: <20190611125904.1013-1-cai@lca.pw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 13 Jun 2019 10:55:33 +0200
Message-ID: <CAK8P3a1rK79aj38H0i9vnzeycv6YZ0iUhBFz4giAFc7COTnmWQ@mail.gmail.com>
Subject: Re: [PATCH -next] efi/tpm: fix a compilation warning
To:     Qian Cai <cai@lca.pw>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>, mjg59@google.com,
        linux-efi <linux-efi@vger.kernel.org>, bsz@semihalf.com,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 11, 2019 at 3:59 PM Qian Cai <cai@lca.pw> wrote:
>
> The linux-next "tpm: Reserve the TPM final events table" [1] introduced
> a compilation warning,
>
> drivers/firmware/efi/tpm.c: In function 'efi_tpm_eventlog_init':
> drivers/firmware/efi/tpm.c:80:10: warning: passing argument 1 of
> 'tpm2_calc_event_log_size' makes pointer from integer without a cast
> [-Wint-conversion]
>   tbl_size = tpm2_calc_event_log_size(efi.tpm_final_log
> drivers/firmware/efi/tpm.c:19:43: note: expected 'void *' but argument
> is of type 'long unsigned int'
>
> Fix it by making a necessary cast for the argument 1 of
> tpm2_calc_event_log_size().
>
> [1] https://lore.kernel.org/linux-efi/20190520205501.177637-3-matthewgarrett@google.com/
>
> Signed-off-by: Qian Cai <cai@lca.pw>

I see the same build warning, but I don't think adding a cast here
solves the problem:

- efi.tpm_final_log is a physical address that gets passed into
  memremap() to return a pointer
- tpm2_calc_event_log_size() takes a pointer argument and
  dereferences it.

My best guess is that we should pass the output of memremap()
here rather than the input:

--- a/drivers/firmware/efi/tpm.c
+++ b/drivers/firmware/efi/tpm.c
@@ -75,7 +75,7 @@ int __init efi_tpm_eventlog_init(void)
                goto out;
        }

-       tbl_size = tpm2_calc_event_log_size(efi.tpm_final_log
+       tbl_size = tpm2_calc_event_log_size(final_tbl
                                            + sizeof(final_tbl->version)
                                            + sizeof(final_tbl->nr_events),
                                            final_tbl->nr_events,

No idea if that is actually what was intended here, but it makes
the code look more plausible.

        Arnd
