Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 223AB454212
	for <lists+linux-efi@lfdr.de>; Wed, 17 Nov 2021 08:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbhKQHxf (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Nov 2021 02:53:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:42534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232915AbhKQHxe (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 17 Nov 2021 02:53:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F13C361BD2;
        Wed, 17 Nov 2021 07:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637135436;
        bh=yQY9R0lrcyoB7swIATJ2qgVM1QwPaUY/bwGkzyWzf8o=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CG89rB9WFnNZQ2FJ4DaQ81FyG0DEkn0fnW4Y25UINXiGfEvq7s9BN7oCK7ncXIP4X
         ekg7NdN9ETKoDjr+/P+6rT3TvH/aWrwev33yMMPFRSEP3DVY4WAEmSTV8kyjcrtxps
         /CHNGB53jrt22BZE2sTtk4MpOvA2iPYOn1pND5NFiOz3jQy6QEFjQAMdVrf+X6AD2R
         UED/q6YKAXV+F7xO+xGtvlln3PgQYIguDIWuskjME2RcJnv34MD+mZgvioWZyhmC1g
         tsY/5sAIGGgGBr74tKuSf0VKhtNQ1ExBg3+AGs/fnTdVucxMJnK806hUsPXZUNv405
         SexUNgmrzN33A==
Message-ID: <8fcadcf2a5da5118fb7f9caea0a61440525a67b2.camel@kernel.org>
Subject: Re: [PATCH v7 00/17] Enroll kernel keys thru MOK
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Eric Snowberg <eric.snowberg@oracle.com>, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, dwmw2@infradead.org,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        jmorris@namei.org, serge@hallyn.com, keescook@chromium.org,
        torvalds@linux-foundation.org, weiyongjun1@huawei.com,
        nayna@linux.ibm.com, ebiggers@google.com, ardb@kernel.org,
        nramas@linux.microsoft.com, lszubowi@redhat.com, jason@zx2c4.com,
        linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-security-module@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, pjones@redhat.com
Date:   Wed, 17 Nov 2021 09:50:33 +0200
In-Reply-To: <YZPevFtTucji7gIm@0xbeefdead.lan>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
         <eac5f11d7ddcc65d16a9a949c5cf44851bff8f5f.camel@kernel.org>
         <YZPZww0bafYEQ0VS@0xbeefdead.lan>
         <f30a1399208a88257b3ff25b369088cf88a96367.camel@kernel.org>
         <YZPevFtTucji7gIm@0xbeefdead.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2021-11-16 at 11:39 -0500, Konrad Rzeszutek Wilk wrote:
> On Tue, Nov 16, 2021 at 06:24:52PM +0200, Jarkko Sakkinen wrote:
> > On Tue, 2021-11-16 at 11:18 -0500, Konrad Rzeszutek Wilk wrote:
> > > > > I have included=C2=A0 a link to the mokutil [5] changes I have ma=
de to support=20
> > > > > this new functionality.=C2=A0 The shim changes have now been acce=
pted
> > > > > upstream [6].
> > >=20
> > > ..snip..
> > > > > [6] https://github.com/rhboot/shim/commit/4e513405b4f164171011578=
0d19dcec130c5208f
> > >=20
> > > ..snip..
> > > >=20
> > > > Does shim have the necessary features in a release?
> > >=20
> > > Hi!
> > >=20
> > > It has been accepted in the upstream shim. If you are looking
> > > for a distribution having rolled out a shim with this feature (so sig=
ned
> > > by MSF) I fear that distributions are not that fast with shim release=
s.
         ~~~

Should that be MS, or what does MSF mean?

> > >=20
> > > Also these:
> > > https://github.com/rhboot/shim/pulls
> > > https://github.com/rhboot/shim/issues
> > >=20
> > > do mean some extra work would need to go in before an official
> > > release is cut.
> > >=20
> > > Hope this helps?
> >=20
> > Yes. I'll hold with this up until there is an official release. Thank y=
ou.
>=20
> Not sure I understand - but what are the concerns you have with shim
> code that has been accepted?

Maybe my concern is that none of the patches have a tested-by?

Probably would be easier to get a test coverage, e.g. for people like
me who do not even know how to self-compile Shim, how to setup user
space using the product and so forth.

I don't demand a release, if the changes have been accepted, but 17
patches do need to be tested.

/Jarkko


