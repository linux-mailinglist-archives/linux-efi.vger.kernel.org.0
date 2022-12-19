Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E071650D04
	for <lists+linux-efi@lfdr.de>; Mon, 19 Dec 2022 15:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiLSOHo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 19 Dec 2022 09:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiLSOHn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 19 Dec 2022 09:07:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4640DF7E;
        Mon, 19 Dec 2022 06:07:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5335EB80E47;
        Mon, 19 Dec 2022 14:07:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6784C433D2;
        Mon, 19 Dec 2022 14:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671458860;
        bh=jnYINdu24VdAEVzqnIj/Cg8Ji+aqIMSc48Z2PvyIMUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c3WPBXdM0YVicDy0txiCVE73O37zNcVLq22Pl5JMouVBWHouD49EZ7bj60g+l7EbZ
         K/hNDZjPj8uCzbcBKlpjDYYhhUjTft0IVjyW4mPaSUjtxFk9k2osuGs8tLeHTesgEL
         lswNlO/d2USBhvr2N6qSpuAH8SkHi4Ct/aBZL+yzAwmRyrGGRbvVhCRoDipVyQ0NyA
         LNiAxIit1YdfC68PV15f9RkoMJ/DeWRRI3/JiQqHiATiDMjmGABp0CUw0eQ03RdjdE
         Tnb4u1hjQcMOaYW9Z85ejoib1c9mF8R9O0RkOEMbtYiGORuFvRSPB18LKDmv2rDAUA
         t5x0lbLOtXK0g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p7GoY-00008j-P7; Mon, 19 Dec 2022 15:08:22 +0100
Date:   Mon, 19 Dec 2022 15:08:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>
Subject: Re: [PATCH v2] efi: random: fix NULL-deref when refreshing seed
Message-ID: <Y6BwVj93vv3hYoOe@hovoldconsulting.com>
References: <20221219101237.9872-1-johan+linaro@kernel.org>
 <Y6Bucfoykf2lMdQQ@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6Bucfoykf2lMdQQ@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Dec 19, 2022 at 03:00:17PM +0100, Jason A. Donenfeld wrote:
> On Mon, Dec 19, 2022 at 11:12:37AM +0100, Johan Hovold wrote:
> > Do not try to refresh the RNG seed in case the firmware does not support
> > setting variables.
> > 
> > This is specifically needed to prevent a NULL-pointer dereference on the
> > Lenovo X13s with some firmware revisions, or more generally, whenever
> > the runtime services have been disabled (e.g. efi=noruntime or with
> > PREEMPT_RT).
> > 
> > Fixes: e7b813b32a42 ("efi: random: refresh non-volatile random seed when RNG is initialized")
> > Reported-by: Steev Klimaszewski <steev@kali.org>
> > Reported-by: Bjorn Andersson <andersson@kernel.org>
> > Tested-by: Andrew Halaney <ahalaney@redhat.com> # sc8280xp-lenovo-thinkpad-x13s
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> > 
> > Changes in v2
> >  - amend commit message with a comment on this being needed whenever the
> >    runtime services have been disabled
> 
> I'll queue up the one with the amended commit message.

Perfect, thanks!

Johan
