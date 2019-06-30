Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39E6B5B1F1
	for <lists+linux-efi@lfdr.de>; Sun, 30 Jun 2019 23:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbfF3VFk (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 30 Jun 2019 17:05:40 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44121 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfF3VFj (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 30 Jun 2019 17:05:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id k8so19150578edr.11;
        Sun, 30 Jun 2019 14:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nWkSzfQwWe28Oid571VUDPT1j3jqJiizt+sPBUmyYXc=;
        b=usPdyelnSi4jYetKhxTjSp/C2Q/tSyY8vTWVz/sIz0yvDaZBJ4EdBe/mK0qEldHi3S
         44UE591gyw85bU15D17RNz4Xsc21haFCBRfg/ApmA3FtCoLOxsj4a58gKbgiS7sWDUxj
         v+9OECxNgNMECzxJXN0Q7AIAhZBOTQEKynq9Pp8Nt6ZxVU8lYTzbwu2dBnvt13Ev+6E1
         8NNOVzv4Y6InY8NZf8H0qzlFSngI8tO0e/DO6QlSi6qH9eqXtIScDtnrUsDIPRYAV2hd
         TTXgBe/RHYEmqX/1n7ZEwwr9uHpsbWwgiisrGDAg26d6gjCjOcXgcmV6awhVUrBETPO5
         AtTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWkSzfQwWe28Oid571VUDPT1j3jqJiizt+sPBUmyYXc=;
        b=qJIxJwYjbqQ8VukUqI5yvF3AWX13/yITaXHoCuStc908PwnXQ5eIPGnR3bNBGX47+D
         R5EPEWRqlIZL54MNTx1wpJ0YhzyT8fXqiLq4K4OjnJapEaJ8Hr5zClb3JjHWv8jc0J1F
         ICv94jfpxB8wj6sXZ1NBu+pSqbGEZvYd3ZLKqozbfvbBBxX2o9TTVqyB2a/vpA8grRh7
         y5Xda19vsg+TjFvapA14W/egXtSa36Q3FrSojacxAjobyuVwm1UTSNjxl5BXLiUMUvYn
         HSpXLqlxyondRrra4ZPzRdtiTaNSLAFEhRecNMGYOklXXujIpKVqsk/UvRIkMLjOusa3
         +hew==
X-Gm-Message-State: APjAAAUsPqrArYtbrK93GtspGcn74igvHNX8NYPid+ka0tLLzOxGZuwt
        qp/ATipXCG4uiCKdYzgEy6hElQimqweClPbSEDM=
X-Google-Smtp-Source: APXvYqyQ0wkKlgKDPqKrVBswiHBd8q2VTYiTxeXwUHkwUHPU3FRmk6Q91V6nRILqCyOCnPwhUWrbZa4ZFHhJIU1RIK8=
X-Received: by 2002:a17:906:f85:: with SMTP id q5mr18711715ejj.192.1561928737016;
 Sun, 30 Jun 2019 14:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20190630203614.5290-1-robdclark@gmail.com> <20190630204723.GH7043@pendragon.ideasonboard.com>
In-Reply-To: <20190630204723.GH7043@pendragon.ideasonboard.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Sun, 30 Jun 2019 14:05:21 -0700
Message-ID: <CAF6AEGvA-wVyC4jJC-nZU-pdVH=KYtye9twDgup-Nq0C_+wtvQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] drm+dt+efi: support devices with multiple possible panels
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        aarch64-laptops@lists.linaro.org,
        Rob Clark <robdclark@chromium.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Julien Thierry <julien.thierry@arm.com>,
        "open list:EXTENSIBLE FIRMWARE INTERFACE (EFI)" 
        <linux-efi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>,
        Steve Capper <steve.capper@arm.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, Jun 30, 2019 at 1:47 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Rob,
>
> Thank you for the patch.
>
> On Sun, Jun 30, 2019 at 01:36:04PM -0700, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Now that we can deal gracefully with bootloader (firmware) initialized
> > display on aarch64 laptops[1], the next step is to deal with the fact
> > that the same model of laptop can have one of multiple different panels.
> > (For the yoga c630 that I have, I know of at least two possible panels,
> > there might be a third.)
>
> I have to ask the obvious question: why doesn't the boot loader just
> pass a correct DT to Linux ? There's no point in passing a list of
> panels that are not there, this seems quite a big hack to me. A proper
> boot loader should construct the DT based on hardware detection.

Hi Laurent,

Actually the bootloader on these devices is passing *no* dt (they boot
ACPI, we are loading dtb from grub currently)

I think normally a device built w/ dt in mind would populate
/chosen/panel-id directly (rather than the way it is currently
populated based on reading an efi variable prior to ExitBootServices).
But that is considerably easier ask than having it re-write of_graph
bindings.  Either way, we aren't in control of the bootloader on these
devices, so it is a matter of coming up with something that works on
actual hw that we don't like rather than idealized hw that we don't
have ;-)

BR,
-R
