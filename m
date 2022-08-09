Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137C858DA18
	for <lists+linux-efi@lfdr.de>; Tue,  9 Aug 2022 16:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243189AbiHIOI0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 9 Aug 2022 10:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238333AbiHIOIZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 9 Aug 2022 10:08:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A733712755
        for <linux-efi@vger.kernel.org>; Tue,  9 Aug 2022 07:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660054098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lrKZYmnWUxzeShUKgQKXDr1WtsqUMg/WhYfT8esF3Oo=;
        b=XkiyALkuX+Xgzt+Gjf+3K6DXXGDTeSZmBblgdFyEUV2dInnpScQNehp23jtv/m9Z2Xx+y+
        RE1yKrgAfvJoOZYVEU0dPoZD7/LXoKRvzOIBjdjjguwgGgiHHCJjwkH7wPYda8/Ag2UtGc
        LJABCRmavgqCsDiHyfQEBLC+HQ+T3iM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-iNUFQDfXPeyF0nIStyhupw-1; Tue, 09 Aug 2022 10:08:15 -0400
X-MC-Unique: iNUFQDfXPeyF0nIStyhupw-1
Received: by mail-wr1-f70.google.com with SMTP id v5-20020adfa1c5000000b002205c89c80aso1858059wrv.6
        for <linux-efi@vger.kernel.org>; Tue, 09 Aug 2022 07:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=lrKZYmnWUxzeShUKgQKXDr1WtsqUMg/WhYfT8esF3Oo=;
        b=CX078aXb7RZr8vQWZVUPDZMHcJN3E1t4i3rgw+ET8FpS82jXwDKQSeBYMtfRWoUcli
         7XYvBc/y4seGXmfsAJovmELq0b13LKVfFp+3e/1Xpw7luX0L2rwCckHOpeoZUV9EazqU
         hsIMfe2j6DCvJy8a5DkRscIH8mWFuF0glQfBQrQSXYoW3KGPRgopKJHsOvkzTxxPnL7E
         h3mbbaq85eZAnDMks7S2kEe7QT8LsUOxws9C5BoK4HSWbF0Cpz5e5O8HoE7XVYn1vPAi
         jEohHCJlNnNWH2nWAM9oARwWftKP+/KY3ZCSOaEJVNXmRy3kTQDj/s7CLNCTHoM3PUB1
         D/1g==
X-Gm-Message-State: ACgBeo0H9gso+rLaENXiapHVXQhpe3WJr2w0d1oC4m9NmpTdYKOC1/6o
        NUWj0279h4AkgfGVTTNVUE8CB6JkNki8CZq/jcH7XE/UOjMcwEvXOJWiqUxhn6WIVls9NUS385C
        HLv6jijWKAotow62wyp2q
X-Received: by 2002:a05:6000:a1a:b0:21f:10a3:924 with SMTP id co26-20020a0560000a1a00b0021f10a30924mr14856892wrb.650.1660054070539;
        Tue, 09 Aug 2022 07:07:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7LXemJ2SoOuxnr52sK/fid1JNs4wiJsQT0kAmh9b8CClPePmSSEvmcaFugSb864/KrZN00kQ==
X-Received: by 2002:a05:6000:a1a:b0:21f:10a3:924 with SMTP id co26-20020a0560000a1a00b0021f10a30924mr14856877wrb.650.1660054070279;
        Tue, 09 Aug 2022 07:07:50 -0700 (PDT)
Received: from redhat.com ([2.52.152.113])
        by smtp.gmail.com with ESMTPSA id f6-20020a1c6a06000000b003a5a47d1226sm699449wmc.42.2022.08.09.07.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 07:07:48 -0700 (PDT)
Date:   Tue, 9 Aug 2022 10:07:44 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Laszlo Ersek <lersek@redhat.com>, linux-efi@vger.kernel.org
Subject: Re: [PATCH v3] hw/i386: place setup_data at fixed place in memory
Message-ID: <20220809100724-mutt-send-email-mst@kernel.org>
References: <YuxOgtykRQb1HU3e@zx2c4.com>
 <20220804230411.17720-1-Jason@zx2c4.com>
 <40fdfb11-1e40-a36a-d3a4-fcbef546a78a@redhat.com>
 <Yu0RX2b+e9BpGsJ6@zx2c4.com>
 <YvJQU0vS3sKDNPWn@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvJQU0vS3sKDNPWn@zx2c4.com>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Aug 09, 2022 at 02:17:23PM +0200, Jason A. Donenfeld wrote:
> Hey Paolo,
> 
> On Fri, Aug 05, 2022 at 02:47:27PM +0200, Jason A. Donenfeld wrote:
> > Hi Paolo,
> > 
> > On Fri, Aug 05, 2022 at 10:10:02AM +0200, Paolo Bonzini wrote:
> > > On 8/5/22 01:04, Jason A. Donenfeld wrote:
> > > > +    /* Nothing else uses this part of the hardware mapped region */
> > > > +    setup_data_base = 0xfffff - 0x1000;
> > > 
> > > Isn't this where the BIOS lives?  I don't think this works.
> > 
> > That's the segment dedicated to ROM and hardware mapped addresses. So
> > that's a place to put ROM material. No actual software will use it.
> > 
> > Jason
> 
> Unless I've misread the thread, I don't think there are any remaining
> objections, right? Can we try merging this and seeing if it fixes the
> issue for good?
> 
> Jason

Laszlo commented here:
https://lore.kernel.org/r/fa0601e4-acf5-0ce8-9277-4d90d046b53e%40redhat.com

-- 
MST

