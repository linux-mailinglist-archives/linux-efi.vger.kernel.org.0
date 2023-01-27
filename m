Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0896D67DF15
	for <lists+linux-efi@lfdr.de>; Fri, 27 Jan 2023 09:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232322AbjA0I2O (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 27 Jan 2023 03:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232375AbjA0I2J (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 27 Jan 2023 03:28:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5931F3C280;
        Fri, 27 Jan 2023 00:28:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 64C6AB81FB4;
        Fri, 27 Jan 2023 08:28:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16CD6C433D2;
        Fri, 27 Jan 2023 08:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674808083;
        bh=uwHiU7RjZoZVDHa0SyaRRViW9F+9wMxGq1EQU6DM0WE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYpgiL+ckjxl8ZEIqNGH+o2jJuQ3S1yw3aDTCjigtCm4G9mXItrtzhjLjWLR4vhdP
         x4lc+f4Sc+kI5KPsyCLQfDIjeZeoOid1BvXtwA+mBwAa89g+vzbmcb1MvMhETnKKnQ
         a9CnkVcvtU4+71YvTp7kf/0gCr28ihTUxCGCNMMVQuNbJ3SMdyX+ie6saaWX00xq38
         7gYqsHu6plq0Qlx7BtMqrw7GFO+2d7r9YboK85j9SqUpFqa8DPNIwES4ohAQ2VadOL
         KMYmgrCpNgZZnUcFIuVCre5nxfXsP+Oi26beP8AzngPSaklFcJlh1N+ugtF5IdX1cV
         +psH29okISlOA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pLK5j-0004rS-Fi; Fri, 27 Jan 2023 09:28:11 +0100
Date:   Fri, 27 Jan 2023 09:28:11 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steev Klimaszewski <steev@kali.org>
Subject: Re: [PATCH] efivarfs: fix NULL-deref on mount when no efivars
Message-ID: <Y9OLG5/yeuG6KT0f@hovoldconsulting.com>
References: <20230126112129.4602-1-johan+linaro@kernel.org>
 <CAMj1kXEUKChvqA8D_T3Bt-pQhvjBmsGxyy69uqDqyn0EBmQ1pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXEUKChvqA8D_T3Bt-pQhvjBmsGxyy69uqDqyn0EBmQ1pw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jan 26, 2023 at 09:32:27PM +0100, Ard Biesheuvel wrote:
> On Thu, 26 Jan 2023 at 12:23, Johan Hovold <johan+linaro@kernel.org> wrote:
> >
> > The VFS calls kill_sb() also in case mount fails in get_tree().
> >
> > Add the missing check to make sure that efivars has been registered also
> > to kill_sb() to avoid dereferencing a NULL pointer when trying to remove
> > efivar entries.
> >
> > Fixes: c3fd71b428b8 ("efivarfs: always register filesystem")
> > Reported-by: Steev Klimaszewski <steev@kali.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> Thanks - I have squashed this with the original patch.

Thanks, Ard. And sorry about not catching this before posting.

Johan
