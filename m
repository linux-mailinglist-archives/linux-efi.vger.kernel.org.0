Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7238C2A3C35
	for <lists+linux-efi@lfdr.de>; Tue,  3 Nov 2020 06:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgKCFwC (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 3 Nov 2020 00:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbgKCFwB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 3 Nov 2020 00:52:01 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B9BC0617A6
        for <linux-efi@vger.kernel.org>; Mon,  2 Nov 2020 21:52:01 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id n18so17086035wrs.5
        for <linux-efi@vger.kernel.org>; Mon, 02 Nov 2020 21:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tWcybe14rkXYQDSwYbH1lu68b5IsE2Pp14TXMsxmmMA=;
        b=MZiJrG7aRphHJS3oHBOYLh7Otw/ygZg0qad4GQERIOF1zf4R3QNHD6h716lNKmXa7e
         ExANUIFgnUYxct4SK8VJ4VeHSrgcwW2HHkRnISTl+NEn++S3ZP1CtmLPoE+xZKTBMfIL
         jh/Nw6ZLQFPz17Bw8KxF4rYRb2y88/C+RILVwurwqPpLwQ2jzSE7MIrRkDhDHODKY8zb
         GPG8J0jbiNEzeINBxmzDZmIh/erAMTCqXD4lmjVi7Xbb0rYvNs4iskS1yky0vhBPUpI+
         8NUex4DfINXqa4gXWhSKQZyN6yKhiQId3sIGQZ7BxclptcG3NVGRswv3i4wy86CGt7Q/
         wa8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tWcybe14rkXYQDSwYbH1lu68b5IsE2Pp14TXMsxmmMA=;
        b=rG3sbR0mj0OLsV/tVM+PYge0q6HiHK/LdcosEjAMgZxxi/R9YZ8KPgZBKffz8nioT+
         LlAm2F6PruWKqUtjnEeLlGQ2rhgLeQlW6tVlTorqhqkyMBJwOapr6+kRDU2L3H5Opqbo
         lcg1VoTelhM4opIP55i0pbuclFcrbRbAYgHhMpgJUgX3KLK/V9MJ8k30U3NEDn1q67gn
         b6MVdXCcYjhhTqbbRTeoLJ62zWLPlVe3sMoRzECLyeDdpsroW6YIQgAXfbL9PWdFHUAf
         0+UE6KuneXIKAEL+Mu4CvmU1wGX2dWWWwytq0HX6Tw67HFVfVG9ew6CY+I1OsJK3Av3e
         V/8Q==
X-Gm-Message-State: AOAM532KnFjVJFuG6vCeiMya1ZBgnThGv/qtJlxJRIPijj8+MDU2SLuF
        359rNmB8MMCSOgbi0BLGVzUaiQ==
X-Google-Smtp-Source: ABdhPJy7xIELe7ekHbQQo59WLDUEqSVPhDpQ0Q/vth0LAZs4RYUgcgbf7EsmjTIc/tbex9QhXMLybw==
X-Received: by 2002:a5d:4409:: with SMTP id z9mr23586841wrq.236.1604382719784;
        Mon, 02 Nov 2020 21:51:59 -0800 (PST)
Received: from apalos.home (athedsl-246545.home.otenet.gr. [85.73.10.175])
        by smtp.gmail.com with ESMTPSA id 6sm13171716wrc.88.2020.11.02.21.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 21:51:59 -0800 (PST)
Date:   Tue, 3 Nov 2020 07:51:56 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Peter Jones <pjones@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Matthew Garrett <mjg59@google.com>,
        Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: [RFC PATCH 0/7] efi/libstub: measurement initrd data loaded by
 the EFI stub
Message-ID: <20201103055156.GA355267@apalos.home>
References: <20201102170634.20575-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201102170634.20575-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Ard,

On Mon, Nov 02, 2020 at 06:06:27PM +0100, Ard Biesheuvel wrote:
> This series enables measurement of the initrd data loaded directly by the
> EFI stub into the TPM, using the TCG2 protocol exposed by the firmware (if
> available). This ensures that the initrd observed and used by the OS is the
> same one that got measured into the TPM, which is more difficult to guarantee
> in the current situation.
> 

I like this. The OS gets the ability to 'self-measure' one critical component.
This can of course be done in the bootloader or GRUB, but having the functionality
in the stub will allow you to boot with a verified initrd, if even GRUB isn't 
there or the bootloader doesn't measure the initrd.

> This is posted as an RFC since it is mostly an invitation to discuss how
> we can fit this into a longer term strategy for arch-agnostic secure and
> measured boot that does not hinge on the Shim+GRUB tandem, or on deep
> knowledge on the part of the bootloader regarding device trees, bootparams
> structs, allocation and placement policies of various artifacts etc etc
> 
> Open questions:
> - Should we do this?

I think so. I can't find any arguments why we shouldn't.

> - Are Linux systems in the field using PCR value prediction when updating the
>   initrd? Does this approach interfere with that?
> - Which PCR and event type to use

No idea. I think distros will have an opinion on that

> - Is a separator event needed here, given that the initrd measurement is
>   recorded even if no initrd was loaded by the stub?

I think having the event make sense, but if we going to make a standard 
measurement for the initrd, we need to discuss this a bit more.

> 
> Note that the EFI stub ignores the initrd provided directly via bootparams or
> the device tree, and it would be nice if we could keep doing that.
> 
> Build tested only.


Cheers
/Ilias

> 
> Cc: Peter Jones <pjones@redhat.com>
> Cc: Leif Lindholm <leif@nuviainc.com>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Matthew Garrett <mjg59@google.com>
> Cc: Daniel Kiper <daniel.kiper@oracle.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> 
> Ard Biesheuvel (7):
>   efi/libstub: whitespace cleanup
>   efi/libstub: fix prototype of efi_tcg2_protocol::get_event_log()
>   efi/libstub: x86/mixed: increase supported argument count
>   efi/libstub: move TPM related prototypes into efistub.h
>   efi/libstub: add prototype of
>     efi_tcg2_protocol::hash_log_extend_event()
>   efi/libstub: consolidate initrd handling across architectures
>   efi/libstub: measure loaded initrd info into the TPM
> 
>  arch/x86/boot/compressed/efi_thunk_64.S       | 17 ++++--
>  arch/x86/include/asm/efi.h                    | 13 +++--
>  arch/x86/platform/efi/efi_thunk_64.S          | 17 ++++--
>  .../firmware/efi/libstub/efi-stub-helper.c    | 56 +++++++++++++++----
>  drivers/firmware/efi/libstub/efi-stub.c       | 10 +---
>  drivers/firmware/efi/libstub/efistub.h        | 34 ++++++++++-
>  drivers/firmware/efi/libstub/x86-stub.c       | 26 ++++-----
>  include/linux/efi.h                           | 13 +----
>  8 files changed, 123 insertions(+), 63 deletions(-)
> 
> -- 
> 2.17.1
> 
