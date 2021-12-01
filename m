Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B638464B99
	for <lists+linux-efi@lfdr.de>; Wed,  1 Dec 2021 11:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348642AbhLAKb0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 1 Dec 2021 05:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348628AbhLAKb0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 1 Dec 2021 05:31:26 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38551C061574;
        Wed,  1 Dec 2021 02:28:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 389FDCE1DB2;
        Wed,  1 Dec 2021 10:28:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D209AC53FCC;
        Wed,  1 Dec 2021 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638354481;
        bh=m6mcqbYuHeMeS8hGqq/RnBLl6KXb9FndE6k43W6VWWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VA3AxZbGfIiJSQyqUMMErcKvc7GlztLuXaxI6MfnvTIi8GJd0KlUku7RdXKYYc7DD
         QwFn+fCa08o6c1SaDDMV5GXaCBra2i5oKaNn3+iKK/iwpdDtKbvIV/A4IA7LWVqgu+
         WOppeNg/PZbQ/feuQw1y19GjoYIrNW4CqJ4c5ePkH8TfxeS8Zcf9nFdpW1r99vCTVr
         BLrWzLjILbGWwljOpKUAk32T20jSEGE/vViTW/0pyufacOkXi0Swu6y7ED3Lkq0xX8
         HOifikPZyAZpkbveo7+dDfD8BepfUhyK/68Gy1Bvi9xeZNTcTyLr/tBWDioq2cRSGo
         wS9Zq0FPdRzdQ==
Date:   Wed, 1 Dec 2021 12:27:58 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>
Cc:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "weiyongjun1@huawei.com" <weiyongjun1@huawei.com>,
        "nayna@linux.ibm.com" <nayna@linux.ibm.com>,
        "ebiggers@google.com" <ebiggers@google.com>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "nramas@linux.microsoft.com" <nramas@linux.microsoft.com>,
        "lszubowi@redhat.com" <lszubowi@redhat.com>,
        "jason@zx2c4.com" <jason@zx2c4.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH v8 09/17] KEYS: Rename
 get_builtin_and_secondary_restriction
Message-ID: <YadOLrHb14MEfphi@iki.fi>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-10-eric.snowberg@oracle.com>
 <fb1d583f588e3f46fdadbe3cf6288bb098ff45f8.camel@kernel.org>
 <8906F8A4-313F-45E5-8ABD-A1A2D07BFD93@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8906F8A4-313F-45E5-8ABD-A1A2D07BFD93@oracle.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Nov 30, 2021 at 05:21:45PM +0000, Eric Snowberg wrote:
> 
> 
> > On Nov 26, 2021, at 5:49 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > 
> > On Tue, 2021-11-23 at 23:41 -0500, Eric Snowberg wrote:
> >> In preparation for returning either the existing
> >> restrict_link_by_builtin_and_secondary_trusted or the upcoming
> >> restriction that includes the trusted builtin, secondary and
> >> machine keys, to improve clarity, rename
> >> get_builtin_and_secondary_restriction to get_secondary_restriction.
> >> 
> >> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> >> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> >> ---
> >> v6: Initial version
> >> v7: Unmodified from v7
> >> v8: Code unmodified from v7, added Mimi's Reviewed-by
> >> ---
> >>  certs/system_keyring.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> >> index 692365dee2bd..8f1f87579819 100644
> >> --- a/certs/system_keyring.c
> >> +++ b/certs/system_keyring.c
> >> @@ -77,7 +77,7 @@ int restrict_link_by_builtin_and_secondary_trusted(
> >>   * Allocate a struct key_restriction for the "builtin and secondary trust"
> >>   * keyring. Only for use in system_trusted_keyring_init().
> >>   */
> >> -static __init struct key_restriction *get_builtin_and_secondary_restriction(void)
> >> +static __init struct key_restriction *get_secondary_restriction(void)
> >>  {
> >>         struct key_restriction *restriction;
> >>  
> >> @@ -117,7 +117,7 @@ static __init int system_trusted_keyring_init(void)
> >>                                KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH |
> >>                                KEY_USR_WRITE),
> >>                               KEY_ALLOC_NOT_IN_QUOTA,
> >> -                             get_builtin_and_secondary_restriction(),
> >> +                             get_secondary_restriction(),
> >>                               NULL);
> >>         if (IS_ERR(secondary_trusted_keys))
> >>                 panic("Can't allocate secondary trusted keyring\n");
> > 
> > This is wrong order.
> > 
> > You should first do the changes that make the old name
> > obsolete and only after that have a patch that does the
> > rename. Unfortunately, this patch cannot possibly acked
> > with the current order.
> 
> I can change the order, but I'm confused how this would work for a git bisect. 
> If the rename happens afterwards, now two patches will always need to be 
> reverted instead of the possibility of one.  Is this your expectation?

I'd drop this patch altogether. Old name is a bit ugly but does it matter
all that much?

You already 16 patches without this.

/Jarkko
