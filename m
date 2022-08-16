Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EF5595784
	for <lists+linux-efi@lfdr.de>; Tue, 16 Aug 2022 12:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiHPKHZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Aug 2022 06:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbiHPKHB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 16 Aug 2022 06:07:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1F263AB15
        for <linux-efi@vger.kernel.org>; Tue, 16 Aug 2022 01:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660640124;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fcnqwnWtPrrvQuTtaWbHZpJ2oy+s8SGKXBXZ/UhqXho=;
        b=dIg+eMszH3NXxKS06ECxemX4z4sT2elqmL7vUZmTsFXxiF4SukHNAmxhPIG1x6hU3DLiM4
        2gPWmxqmxAdr7o4wlEpmgBiFb7Am4fUg1niZmJuUwxf9kSoe90i06J3+I40LhLvB+GIq9P
        h7d+81HnN5TnPldUxDZtZr0K6glp3Ow=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-Byi7xf3fOISl72gwyChfYg-1; Tue, 16 Aug 2022 04:55:14 -0400
X-MC-Unique: Byi7xf3fOISl72gwyChfYg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A4048811E75;
        Tue, 16 Aug 2022 08:55:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E5941140EBE3;
        Tue, 16 Aug 2022 08:55:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8FFF918003A8; Tue, 16 Aug 2022 10:55:11 +0200 (CEST)
Date:   Tue, 16 Aug 2022 10:55:11 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Laszlo Ersek <lersek@redhat.com>, Ard Biesheuvel <ardb@kernel.org>,
        Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        QEMU Developers <qemu-devel@nongnu.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
Message-ID: <20220816085511.nw5w3wt5vemkyryt@sirius.home.kraxel.org>
References: <YusVVLNbLgsk49PK@zx2c4.com>
 <20220804004411.1343158-1-Jason@zx2c4.com>
 <20220804030012-mutt-send-email-mst@kernel.org>
 <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
 <YuuQb3D/YY1SiUqY@redhat.com>
 <Yuu1kX9CAqSUNNAj@zx2c4.com>
 <Yuu3ee1iB3IoLdZS@redhat.com>
 <CAMj1kXFAz1ttRmt5_utReSC=TjdfmrgwbwSaAZTDnx6OPGuRRg@mail.gmail.com>
 <cf60456e-a2cd-a64d-0cee-4bea30708fc9@redhat.com>
 <CAHmME9pUdckUwei234Xdge_G-=b6q2e9a8mTVExrV4WE=6TLig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9pUdckUwei234Xdge_G-=b6q2e9a8mTVExrV4WE=6TLig@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

  Hi,

> > We can make setup_data chaining work with OVMF, but the whole chain
> > should be located in a GPA range that OVMF dictates.
> 
> It sounds like what you describe is pretty OVMF-specific though,
> right? Do we want to tie things together so tightly like that?
> 
> Given we only need 48 bytes or so, isn't there a more subtle place we
> could just throw this in ram that doesn't need such complex
> coordination?

Joining the party late (and still catching up the thread).  Given we
don't need that anyway with EFI, only with legacy BIOS:  Can't that just
be a protocol between qemu and pc-bios/optionrom/*boot*.S on how to pass
those 48 bytes random seed?

take care,
  Gerd

