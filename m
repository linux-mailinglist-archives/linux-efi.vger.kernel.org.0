Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BBC589B80
	for <lists+linux-efi@lfdr.de>; Thu,  4 Aug 2022 14:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbiHDMMF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 4 Aug 2022 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239674AbiHDMLv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 4 Aug 2022 08:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EE4F66101
        for <linux-efi@vger.kernel.org>; Thu,  4 Aug 2022 05:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659615107;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=myS9hst6VuJLpiFkgxft82/FddB8fppeYsviy0dUtBY=;
        b=Z7DQseXEv8Sj0x1mpnVmwHpElPidjRZ5Utsa++q6sLVEYBByyiLc2QvDDSAjugvPn75h/c
        W0nzVwphUyg0pPl2k6nCAtv0O50gDrfdq/bYRFqWH8neIqipT2YjBDSdRLGhYlxyGYePvt
        nnH6KuVEI5omvOaiYHillWaPGKes/TE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-441-WK2PZhWBMaaXxBd6AmbAPA-1; Thu, 04 Aug 2022 08:11:44 -0400
X-MC-Unique: WK2PZhWBMaaXxBd6AmbAPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41CC9811E80;
        Thu,  4 Aug 2022 12:11:44 +0000 (UTC)
Received: from redhat.com (unknown [10.33.36.223])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AC77E1415116;
        Thu,  4 Aug 2022 12:11:40 +0000 (UTC)
Date:   Thu, 4 Aug 2022 13:11:37 +0100
From:   Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Laszlo Ersek <lersek@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Subject: Re: [PATCH v2] hw/i386: place setup_data at fixed place in memory
Message-ID: <Yuu3ee1iB3IoLdZS@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <YusVVLNbLgsk49PK@zx2c4.com>
 <20220804004411.1343158-1-Jason@zx2c4.com>
 <20220804030012-mutt-send-email-mst@kernel.org>
 <bfa5704d-755c-5a52-e7cc-bd9b34e5bb03@redhat.com>
 <YuuQb3D/YY1SiUqY@redhat.com>
 <Yuu1kX9CAqSUNNAj@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yuu1kX9CAqSUNNAj@zx2c4.com>
User-Agent: Mutt/2.2.6 (2022-06-05)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Aug 04, 2022 at 02:03:29PM +0200, Jason A. Donenfeld wrote:
> Hi Daniel,
> 
> On Thu, Aug 04, 2022 at 10:25:36AM +0100, Daniel P. Berrangé wrote:
> > Yep, and ultimately the inability to distinguish UEFI vs other firmware
> > is arguably correct by design, as the QEMU <-> firmware interface is
> > supposed to be arbitrarily pluggable for any firmware implementation
> > not  limited to merely UEFI + seabios.
> 
> Indeed, I agree with this.
> 
> > 
> > > For now I suggest either reverting the original patch, or at least not
> > > enabling the knob by default for any machine types. In particular, when
> > > using MicroVM, the user must leave the knob disabled when direct booting
> > > a kernel on OVMF, and the user may or may not enable the knob when
> > > direct booting a kernel on SeaBIOS.
> > 
> > Having it opt-in via a knob would defeat Jason's goal of having the seed
> > available automatically.
> 
> Yes, adding a knob is absolutely out of the question.
> 
> It also doesn't actually solve the problem: this triggers when QEMU
> passes a DTB too. It's not just for the new RNG seed thing. This bug
> isn't new.

In the other thread I also mentioned that this RNG Seed addition has
caused a bug with AMD SEV too, making boot measurement attestation
fail because the kernel blob passed to the firmware no longer matches
what the tenant expects, due to the injected seed.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

