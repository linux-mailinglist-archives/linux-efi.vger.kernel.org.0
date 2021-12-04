Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F174686A9
	for <lists+linux-efi@lfdr.de>; Sat,  4 Dec 2021 18:40:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344674AbhLDRn0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 4 Dec 2021 12:43:26 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:43406 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385247AbhLDRnO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 4 Dec 2021 12:43:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3151A60E8C;
        Sat,  4 Dec 2021 17:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 825A8C341C2;
        Sat,  4 Dec 2021 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638639587;
        bh=kQ9J/Pb/miLDIi9F8XefyifBJMWLFvXftgnYx6Gg0xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G8yIUXKuaYDgnt1TiQrKQdX1K+9aYLwi2nGlUl3bXLXJesqTZlcoteyoAF+QnB8zE
         WF29gb6ByQvxjxz3PGmvwdnLwI2kVCOSDsjVbRo7o/CC1P9/70f2539HIqdK1aSFSG
         Qtw6dDTlLUhtQF0i9cdGiw2b9kbVrVj3v+bZfZG3IOPFF0fEWiPzVu29G3NJCDxXx7
         XG4rLiUtJOd8JtRXWYB/1ZUKud7j2xeB/+cwO5kOTpESb61Lg/qwMmpxM2OG0RQFTH
         fzOH27WtjkgIUNWaZe08Qovo1x1h4ZW1x/6IaIJSFImBtCPlACcrr6FBi02CJYKoP9
         eR1GV79KfiYiA==
Date:   Sat, 4 Dec 2021 19:39:43 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
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
Message-ID: <Yaun39iwWoln5/4H@iki.fi>
References: <20211124044124.998170-1-eric.snowberg@oracle.com>
 <20211124044124.998170-10-eric.snowberg@oracle.com>
 <fb1d583f588e3f46fdadbe3cf6288bb098ff45f8.camel@kernel.org>
 <8906F8A4-313F-45E5-8ABD-A1A2D07BFD93@oracle.com>
 <YadOLrHb14MEfphi@iki.fi>
 <61f5d74f861ce1015831649d3bca9272a2e3b7bf.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61f5d74f861ce1015831649d3bca9272a2e3b7bf.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Dec 01, 2021 at 08:46:53AM -0500, Mimi Zohar wrote:
> On Wed, 2021-12-01 at 12:27 +0200, Jarkko Sakkinen wrote:
> > On Tue, Nov 30, 2021 at 05:21:45PM +0000, Eric Snowberg wrote:
> > > 
> > > 
> > > > On Nov 26, 2021, at 5:49 PM, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> > > > 
> > > > On Tue, 2021-11-23 at 23:41 -0500, Eric Snowberg wrote:
> > > >> In preparation for returning either the existing
> > > >> restrict_link_by_builtin_and_secondary_trusted or the upcoming
> > > >> restriction that includes the trusted builtin, secondary and
> > > >> machine keys, to improve clarity, rename
> > > >> get_builtin_and_secondary_restriction to get_secondary_restriction.
> > > >> 
> > > >> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> > > >> Signed-off-by: Eric Snowberg <eric.snowberg@oracle.com>
> > > >> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > > >> ---
> > > >> v6: Initial version
> > > >> v7: Unmodified from v7
> > > >> v8: Code unmodified from v7, added Mimi's Reviewed-by
> > > >> ---
> > > >>  certs/system_keyring.c | 4 ++--
> > > >>  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >> 
> > > >> diff --git a/certs/system_keyring.c b/certs/system_keyring.c
> > > >> index 692365dee2bd..8f1f87579819 100644
> > > >> --- a/certs/system_keyring.c
> > > >> +++ b/certs/system_keyring.c
> > > >> @@ -77,7 +77,7 @@ int restrict_link_by_builtin_and_secondary_trusted(
> > > >>   * Allocate a struct key_restriction for the "builtin and secondary trust"
> > > >>   * keyring. Only for use in system_trusted_keyring_init().
> > > >>   */
> > > >> -static __init struct key_restriction *get_builtin_and_secondary_restriction(void)
> > > >> +static __init struct key_restriction *get_secondary_restriction(void)
> > > >>  {
> > > >>         struct key_restriction *restriction;
> > > >>  
> > > >> @@ -117,7 +117,7 @@ static __init int system_trusted_keyring_init(void)
> > > >>                                KEY_USR_VIEW | KEY_USR_READ | KEY_USR_SEARCH |
> > > >>                                KEY_USR_WRITE),
> > > >>                               KEY_ALLOC_NOT_IN_QUOTA,
> > > >> -                             get_builtin_and_secondary_restriction(),
> > > >> +                             get_secondary_restriction(),
> > > >>                               NULL);
> > > >>         if (IS_ERR(secondary_trusted_keys))
> > > >>                 panic("Can't allocate secondary trusted keyring\n");
> > > > 
> > > > This is wrong order.
> > > > 
> > > > You should first do the changes that make the old name
> > > > obsolete and only after that have a patch that does the
> > > > rename. Unfortunately, this patch cannot possibly acked
> > > > with the current order.
> > >
> > > I can change the order, but I'm confused how this would work for a git bisect. 
> > > If the rename happens afterwards, now two patches will always need to be 
> > > reverted instead of the possibility of one.  Is this your expectation?
> 
> If the keyring name change is independent of any other changes, as
> Jarkko suggested, nothing would break.
> 
> > I'd drop this patch altogether. Old name is a bit ugly but does it matter
> > all that much?
> 
> The name "get_builtin_and_secondary_restriction" implies trust based on
> keys in the ".builtin_trusted_keys" and ".secondary_trusted_keys"
> keyrings.  This patch set is extending that to include keys on the new
> ".machine" keyring, by linking it to the secondary keyring.  Is leaving
> the name unchanged really an option?

Yes, it is an option, as long as it is documented correctly in the
prepending kdoc the symbol name does not matter all that much..

/Jarkko
