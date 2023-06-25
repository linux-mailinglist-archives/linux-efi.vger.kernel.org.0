Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907B373D189
	for <lists+linux-efi@lfdr.de>; Sun, 25 Jun 2023 16:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjFYOoe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 25 Jun 2023 10:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFYOod (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 25 Jun 2023 10:44:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFE113E
        for <linux-efi@vger.kernel.org>; Sun, 25 Jun 2023 07:44:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D13460BBD
        for <linux-efi@vger.kernel.org>; Sun, 25 Jun 2023 14:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C0DC433CB;
        Sun, 25 Jun 2023 14:44:31 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GOMyj6gb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1687704268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ag36k/Ea+vAkVr9b2Jjk521Sf8QbG3xHv+HkB2Kc3M=;
        b=GOMyj6gbIVjo5wXtfFGtxw0OCm/fj8wxB8JcqCxDJ01Z2PoGvUk3hCfiRBWYNMFOyWjtTY
        R9apJ2Tk6xyV0/rPXGEncLfs4PjVNEmzQjHlqjWFpv+Rx8VGBzsdcbSb/Mbl92TuoD6kDd
        ZkWXjbZ5GHA+9wrCYf0K3EXtN0sJSP8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 258d25ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Sun, 25 Jun 2023 14:44:28 +0000 (UTC)
Date:   Sun, 25 Jun 2023 16:44:26 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] efivarfs: Expose RandomSeed variable but with limited
 permissions
Message-ID: <ZJhSysqUcxOqh37n@zx2c4.com>
References: <20230624180446.2048867-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230624180446.2048867-1-ardb@kernel.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Jun 24, 2023 at 08:04:46PM +0200, Ard Biesheuvel wrote:
> The efivarfs pseudo-filesystems exposes all EFI variables as
> world-readable, and carries some logic to prevent accidental deletion
> from bricking a system, by setting the immutable flag on all variables
> whose purpose is unknown.
> 
> When the RandomSeed support was added, we decided not to expose this
> variable via efivarfs at all, given that the kernel itself was intended
> to both produce and consume it directly, without involvement from user
> space. This removed the need to deal with the world-readable default
> permissions (which would be undesirable for the random seed that will be
> used on the next boot), as this would require special handling of the
> RandomSeed variable, given that we cannot restrict those permissions for
> all EFI variables without running the risk of breaking user space.
> 
> Now that the producer side of this mechanism has been reverted [0], it
> is no longer possible to set the RandomSeed variable at all.  Whether
> and how we will replace the in-kernel producer with something more
> robust is still under discussion, but in the mean time, let's relax the
> efivarfs restriction on any direct access of the variable, and instead,
> ensure that it is created as user read-write only, both when the EFI
> varstore is enumerated (at mount time) and when the file is created
> explicitly by user space.
> 
> Also ensure that the file is not created with the immutable flag set so
> that user space can manipulate the file as usual.

Hm, I'm still not so sure we want to open the pandora's box of having to
deal with userspaces writing this. Maybe we can keep it in the kernel
but delay it until a little later in boot so it doesn't cause an
outright bootup hang? Or just bite the bullet and do it at shutdown? I
think I'd prefer just doing it in a delayed workqueue in late/post boot
though.

(On the topic of this patch, technically this only needs to be
write-only, not read-write, right?)

Jason
