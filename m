Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B553A8133
	for <lists+linux-efi@lfdr.de>; Wed,  4 Sep 2019 13:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbfIDLgy (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Sep 2019 07:36:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:51894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfIDLgx (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 4 Sep 2019 07:36:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 570E320820;
        Wed,  4 Sep 2019 11:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567597012;
        bh=a56KG1rm+dxxe4u1p29NlNtKXIQggvIKhjPKOKWs/KQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YXK5LvcsSf+fXLWKyCcDDnoK7JjgM5tb8afue21/iYjn6NS5vzvdc/xIL8kUv7Aql
         ObEyuV6v/38/XFHwUq85kTLTQBMYnGMVEo1cz2ASFWQYXT+HslPLL/neAukQNmT9QZ
         nynLzFH1HhrSNxsUDGSvCMqYIS96U1w1BvcvzrHw=
Date:   Wed, 4 Sep 2019 13:36:50 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nayna <nayna@linux.vnet.ibm.com>, Nayna Jain <nayna@linux.ibm.com>,
        linuxppc-dev@ozlabs.org, linux-efi@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Matthew Garret <matthew.garret@nebula.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        George Wilson <gcwilson@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH] sysfs: add BIN_ATTR_WO() macro
Message-ID: <20190904113650.GA8275@kroah.com>
References: <1566825818-9731-1-git-send-email-nayna@linux.ibm.com>
 <1566825818-9731-3-git-send-email-nayna@linux.ibm.com>
 <20190826140131.GA15270@kroah.com>
 <ff9674e1-1b27-783a-38f3-4fd725353186@linux.vnet.ibm.com>
 <20190826150153.GD18418@kroah.com>
 <87ef0yrqxt.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ef0yrqxt.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Sep 03, 2019 at 01:37:02PM +1000, Michael Ellerman wrote:
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > This variant was missing from sysfs.h, I guess no one noticed it before.
> >
> > Turns out the powerpc secure variable code can use it, so add it to the
> > tree for it, and potentially others to take advantage of, instead of
> > open-coding it.
> >
> > Reported-by: Nayna Jain <nayna@linux.ibm.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >
> > I'll queue this up to my tree for 5.4-rc1, but if you want to take this
> > in your tree earlier, feel free to do so.
> 
> OK. This series is blocked on the firmware support going in, so at the
> moment it might miss v5.4 anyway. So this going via your tree is no
> problem.

Ok, will queue it up now, thanks!

greg k-h
