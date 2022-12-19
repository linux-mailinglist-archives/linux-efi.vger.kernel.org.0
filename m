Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781F16509F4
	for <lists+linux-efi@lfdr.de>; Mon, 19 Dec 2022 11:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbiLSKRu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Dec 2022 05:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiLSKRs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Dec 2022 05:17:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052BADF38;
        Mon, 19 Dec 2022 02:17:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99ECBB80D3B;
        Mon, 19 Dec 2022 10:17:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52477C433EF;
        Mon, 19 Dec 2022 10:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671445057;
        bh=/QXfGOD3evtcg2IoOafPGrPY6yYtV+gJwWD2uiKF/Xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f7G/Jaxqiuq6eW/uhjaNQwDMAFy1oaenCOM1ZU8r+oQmMw6eWzMQJEdkUbbC/Bkki
         0mTsMv3UvtUh9RcCqTQmGzyYxcy2SCsQs6FtEFzugXU45CjWFrKFfqoBYIW/pHScOZ
         caMby89PR6O5IfqB4OpbanUrnksYmjHo2yo+6P/FmGnDzk12V7jiU6nav/LFg7gF75
         GszdSyvORD/+GAbVPlhWPT2/eGWvVRDQyu9I3TUJJovUFis8/QvGGTULgbPSVGUDHb
         baL7VcCFRRACgNTLHpp71xO4wnpfA8/+U9x4ddRaIM8FoeoFgUc2AkHYOnC0gDMQAN
         p4Tu393o9dPnw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p7DDv-0002di-J3; Mon, 19 Dec 2022 11:18:19 +0100
Date:   Mon, 19 Dec 2022 11:18:19 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH] efi: random: fix NULL-deref when refreshing seed
Message-ID: <Y6A6a6DjI6vWiMsP@hovoldconsulting.com>
References: <20221216091514.6298-1-johan+linaro@kernel.org>
 <Y5zJT9Z37GSpd59l@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5zJT9Z37GSpd59l@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 16, 2022 at 12:39:56PM -0700, Jason A. Donenfeld wrote:
> On Fri, Dec 16, 2022 at 10:15:14AM +0100, Johan Hovold wrote:
> > Do not try to refresh the RNG seed in case the firmware does not support
> > setting variables.
> > 
> > This is specifically needed to prevent a NULL-pointer dereference on the
> > Lenovo X13s with some firmware revisions.
> > 
> > Fixes: e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> > Reported-by: Steev Klimaszewski <steev@kali.org>
> > Reported-by: Bjorn Andersson <andersson@kernel.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> 
> Thanks very much for this, and sorry for the breakage. I'll try to get
> this in before rc1 is cut, as I've got some other changes scheduled for
> late in the merge window to send anyway.

In case this one hasn't been picked up yet (it's not in linux-next), I
just sent a v2 with an amended commit message with an explicit mention
that as this is needed whenever the runtime services have been disabled
(e.g. with PREEMPT_RT):

	https://lore.kernel.org/lkml/20221219101237.9872-1-johan+linaro@kernel.org/

Johan
