Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCA9453750
	for <lists+linux-efi@lfdr.de>; Tue, 16 Nov 2021 17:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232017AbhKPQ14 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 16 Nov 2021 11:27:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:44152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232018AbhKPQ1w (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 16 Nov 2021 11:27:52 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6CDDE61452;
        Tue, 16 Nov 2021 16:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637079894;
        bh=R8TUjbzona/14mAw6X3xJh07BJccma1nrJsodrH8riE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=A73hp9O7hSoTJ6cI6KS5T/r2askBHeFC2F40oQpz1Tqo/ZTrIja8JBHFpjqejFL11
         PTv1Ha+IHm68zVNxY/ErHGsvyYqsC+YCLrBytUGVTPfYnUs5wWQKiHfnJQtC+vTMAn
         +HgF67pIWFOP5ryAGU3CJCSJ6yz5Oxn4oTgEdDyMk7SNnUxGFTMjiCNZRRGsMaz9rl
         dlI7if1RDh4XkK/+Rh/DxfPHP9pDdlQw418FBStDFTFkDLNwv9BpUOQfIo3C7njxvs
         qds05UF9l598Q6Ohez508fq4kh7joZf2bjnKmjq5BpbOblnjvnzLH596rTHcb4faVY
         vgsLt7z886Vwg==
Message-ID: <f30a1399208a88257b3ff25b369088cf88a96367.camel@kernel.org>
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
Date:   Tue, 16 Nov 2021 18:24:52 +0200
In-Reply-To: <YZPZww0bafYEQ0VS@0xbeefdead.lan>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
         <eac5f11d7ddcc65d16a9a949c5cf44851bff8f5f.camel@kernel.org>
         <YZPZww0bafYEQ0VS@0xbeefdead.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, 2021-11-16 at 11:18 -0500, Konrad Rzeszutek Wilk wrote:
> > > I have included=C2=A0 a link to the mokutil [5] changes I have made t=
o support=20
> > > this new functionality.=C2=A0 The shim changes have now been accepted
> > > upstream [6].
>=20
> ..snip..
> > > [6] https://github.com/rhboot/shim/commit/4e513405b4f1641710115780d19=
dcec130c5208f
>=20
> ..snip..
> >=20
> > Does shim have the necessary features in a release?
>=20
> Hi!
>=20
> It has been accepted in the upstream shim. If you are looking
> for a distribution having rolled out a shim with this feature (so signed
> by MSF) I fear that distributions are not that fast with shim releases.
>=20
> Also these:
> https://github.com/rhboot/shim/pulls
> https://github.com/rhboot/shim/issues
>=20
> do mean some extra work would need to go in before an official
> release is cut.
>=20
> Hope this helps?

Yes. I'll hold with this up until there is an official release. Thank you.

/Jarkko
