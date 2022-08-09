Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD38458D63E
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 11:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbiHIJRz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 05:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiHIJRb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 05:17:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B5A822509
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 02:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660036643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6trcYL8EDncHyJaXFbNVW+zGgRHix/ZIxOm69DyZV9Y=;
        b=LXhDtnkVp6jhSKhcaPMGJFP8DfhGIgxDCA/F/gsssMA4t3WWkFlq0gxEgGDetXfygFs7hD
        8E9ufl9Zz2CCFsKBC73dxHJOfQqk7L/YeUGTAQS5nYOURvLCFBhxAdVRFHv4zXv9sZyXG9
        vxAx16WGfOhHCSMIzrl2T3tKTASP/WE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-550ta-VUPxaySlsm_vvZ5w-1; Tue, 09 Aug 2022 05:17:21 -0400
X-MC-Unique: 550ta-VUPxaySlsm_vvZ5w-1
Received: by mail-wm1-f70.google.com with SMTP id v64-20020a1cac43000000b003a4bea31b4dso9637931wme.3
        for <linux-efi@vger.kernel.org>; Tue, 09 Aug 2022 02:17:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6trcYL8EDncHyJaXFbNVW+zGgRHix/ZIxOm69DyZV9Y=;
        b=neYOMR41QkTwlYksYgz/R/JIkhgV41Ar0XVR+akpVhwVR+Xw9PisEU64zu4814rl79
         Ih72buPTN+ssIeizmhyq1vyeRIUSG63mxUBQZnRGqWVTbwEp+jAor0yF3hbSpBriztUq
         H2WIza27TX/XFmuDoArO8ZxZImR7QFg0xyXOO4yVYJPsZBCkAjN0PGoYKo20w6syTC8j
         1Iah4sNwYYbkx+OisPnkefqXyzzcXYMEoxvmBdmnPMbIIAvsZvK9qDWKFmmGF1pjKFPU
         uWv0B2hybaCAd8A9KTxbCwYHW7JkPgqexkO/LiJMt7FzuL4s5b12Nr+FJOOg4WfKv0wR
         jIcw==
X-Gm-Message-State: ACgBeo2VsM5YKX3VPKLc808zrgOWoTEZrKhhfAPomrfKvr6Uzrh523IT
        ryf2QJ42dBEtP2qXc9rKeu9Sct0sjQg9EecZhrQCVbaGYndiVHLK+xg0VmyEM4TAJmcPR13+b1x
        r44vrDE4Um9FU7ZMBmQRP
X-Received: by 2002:a05:6000:18a2:b0:221:7db8:de02 with SMTP id b2-20020a05600018a200b002217db8de02mr9529236wri.132.1660036640720;
        Tue, 09 Aug 2022 02:17:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4/PUVjWa52Slm5RRM+bXysuWYsRrGroBh+2BcqIRjSw3TmcBqi5ODfU0VvyzUu+oXHXJnbaw==
X-Received: by 2002:a05:6000:18a2:b0:221:7db8:de02 with SMTP id b2-20020a05600018a200b002217db8de02mr9529225wri.132.1660036640513;
        Tue, 09 Aug 2022 02:17:20 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d48c1000000b0021e6277bc50sm15609071wrs.36.2022.08.09.02.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 02:17:19 -0700 (PDT)
Date:   Tue, 9 Aug 2022 05:17:16 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, qemu-devel@nongnu.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>, linux-efi@vger.kernel.org
Subject: Re: [PATCH v3] hw/i386: place setup_data at fixed place in memory
Message-ID: <20220809051644-mutt-send-email-mst@kernel.org>
References: <YuxOgtykRQb1HU3e@zx2c4.com>
 <20220804230411.17720-1-Jason@zx2c4.com>
 <40fdfb11-1e40-a36a-d3a4-fcbef546a78a@redhat.com>
 <CAMj1kXFDs8HCCCcVAVwjLcATh6MYcUSAha5yvi0ftMw+Ddy_Xg@mail.gmail.com>
 <0bd57fab-836b-9898-9e3f-84dc66eca175@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0bd57fab-836b-9898-9e3f-84dc66eca175@redhat.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Aug 05, 2022 at 07:29:29PM +0200, Paolo Bonzini wrote:
> On 8/5/22 13:08, Ard Biesheuvel wrote:
> > > 
> > > Does it work to place setup_data at the end of the cmdline file instead
> > > of having it at the end of the kernel file?  This way the first item
> > > will be at 0x20000 + cmdline_size.
> > > 
> > Does QEMU always allocate the command line statically like that?
> > AFAIK, OVMF never accesses that memory to read the command line, it
> > uses fw_cfg to copy it into a buffer it allocates itself. And I guess
> > that implies that this region could be clobbered by OVMF unless it is
> > told to preserve it.
> 
> No it's not. :(  It also goes to gBS->AllocatePages in the end.
> 
> At this point it seems to me that without extra changes the whole setup_data
> concept is dead on arrival for OVMF.  In principle there's no reason why the
> individual setup_data items couldn't include interior pointers, meaning that
> the setup_data _has_ to be at the address provided in fw_cfg by QEMU.
> 
> One way to "fix" it would be for OVMF to overwrite the pointer to the head
> of the list, so that the kernel ignores the setup data provided by QEMU.
> Another way would be to put it in the command line fw_cfg blob and teach
> OVMF to use a fixed address for the command line.  Both are ugly, and both
> are also broken for new QEMU / old OVMF.
> 
> In any case, I don't think this should be fixed so close to the release.  We
> have two possibilities:
> 
> 1) if we believe "build setup_data in QEMU" is a feasible design that only
> needs more yak shaving, we can keep the code in, but disabled by default,
> and sort it out in 7.2.
> 
> 2) if we go for an alternative design, it needs to be reverted.  For example
> the randomness could be in _another_ fw_cfg file, and the linuxboot DMA can
> patch it in the setup_data.
> 
> 
> With (2) the OVMF breakage would be limited to -dtb, which more or less
> nobody cares about, and we can just look the other way.
> 
> Paolo


So IIUC you retract your pc: add property for Linux setup_data random
number seed then? It's neither of the two options above.

-- 
MST

