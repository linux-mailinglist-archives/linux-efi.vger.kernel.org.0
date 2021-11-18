Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2128145533E
	for <lists+linux-efi@lfdr.de>; Thu, 18 Nov 2021 04:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbhKRDRQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 17 Nov 2021 22:17:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:54892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239637AbhKRDRP (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 17 Nov 2021 22:17:15 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDD9E61507;
        Thu, 18 Nov 2021 03:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637205255;
        bh=/CsQ1mpqXvq8j6eKOBaGsDwpNoQJqGhnqNZpfFmZkMQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kgVX51Asa5Wqvj478HWtq/8Z1Vsf5aZMylfhRQ1T193i10YWv3gZwPGyMPXRHCSzK
         uBax/QkQCeXGQxDkLk3FkLANV/E5fFPAg4i1OqZTRb9rxZunNe9ZVtfZ4eI7Kr+xZm
         hUWpXCFPw74+6C2pEa1DV+hLeTwaylX65yZ/AuHCPGJJndSIwFLzrFxzi0bNEOh67i
         Ocvkq5iJjXnK5LFDPjmK22CvHLOIFcGm5wDx0FUKkKm2WmR8X6upcHDDUtTILWN2OQ
         SSRG3v6qjE4l+eDRwnTSxQViCMTYStpxud7nSltF8WPErPt/mLqJ3BvjoW+a5sYecD
         qK97S67Sg6/nQ==
Message-ID: <10919ebd45263cd790ef928891ff54e4b3dd1407.camel@kernel.org>
Subject: Re: [PATCH v7 00/17] Enroll kernel keys thru MOK
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>
Cc:     "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "zohar@linux.ibm.com" <zohar@linux.ibm.com>,
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
        <James.Bottomley@HansenPartnership.com>,
        "pjones@redhat.com" <pjones@redhat.com>
Date:   Thu, 18 Nov 2021 05:14:12 +0200
In-Reply-To: <7E672BCB-EEA7-4DB8-AEB1-644B46EBE124@oracle.com>
References: <20211116001545.2639333-1-eric.snowberg@oracle.com>
         <eac5f11d7ddcc65d16a9a949c5cf44851bff8f5f.camel@kernel.org>
         <YZPZww0bafYEQ0VS@0xbeefdead.lan>
         <f30a1399208a88257b3ff25b369088cf88a96367.camel@kernel.org>
         <YZPevFtTucji7gIm@0xbeefdead.lan>
         <8fcadcf2a5da5118fb7f9caea0a61440525a67b2.camel@kernel.org>
         <3939a2fac50d2e836c48855b1b00c7b36659f23f.camel@kernel.org>
         <YZU1lkBkphf73dF+@0xbeefdead.lan>
         <7E672BCB-EEA7-4DB8-AEB1-644B46EBE124@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.40.4-1 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 2021-11-17 at 17:20 +0000, Eric Snowberg wrote:
>=20
>=20
> > On Nov 17, 2021, at 10:02 AM, Konrad Wilk <konrad.wilk@oracle.com> wrot=
e:
> >=20
> > On Wed, Nov 17, 2021 at 09:51:25AM +0200, Jarkko Sakkinen wrote:
> > > On Wed, 2021-11-17 at 09:50 +0200, Jarkko Sakkinen wrote:
> > > > On Tue, 2021-11-16 at 11:39 -0500, Konrad Rzeszutek Wilk wrote:
> > > > > On Tue, Nov 16, 2021 at 06:24:52PM +0200, Jarkko Sakkinen wrote:
> > > > > > On Tue, 2021-11-16 at 11:18 -0500, Konrad Rzeszutek Wilk wrote:
> > > > > > > > > I have included=C2=A0 a link to the mokutil [5] changes I=
 have made to support=20
> > > > > > > > > this new functionality.=C2=A0 The shim changes have now b=
een accepted
> > > > > > > > > upstream [6].
> > > > > > >=20
> > > > > > > ..snip..
> > > > > > > > > [6] https://github.com/rhboot/shim/commit/4e513405b4f1641=
710115780d19dcec130c5208f
> > > > > > >=20
> > > > > > > ..snip..
> > > > > > > >=20
> > > > > > > > Does shim have the necessary features in a release?
> > > > > > >=20
> > > > > > > Hi!
> > > > > > >=20
> > > > > > > It has been accepted in the upstream shim. If you are looking
> > > > > > > for a distribution having rolled out a shim with this feature=
 (so signed
> > > > > > > by MSF) I fear that distributions are not that fast with shim=
 releases.
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~~~
> > > >=20
> > > > Should that be MS, or what does MSF mean?
> >=20
> > Microsoft :-)
>=20
> Correct, I=E2=80=99ll fix that in the next round.
>=20
> > > > > > >=20
> > > > > > > Also these:
> > > > > > > https://github.com/rhboot/shim/pulls
> > > > > > > https://github.com/rhboot/shim/issues
> > > > > > >=20
> > > > > > > do mean some extra work would need to go in before an officia=
l
> > > > > > > release is cut.
> > > > > > >=20
> > > > > > > Hope this helps?
> > > > > >=20
> > > > > > Yes. I'll hold with this up until there is an official release.=
 Thank you.
> > > > >=20
> > > > > Not sure I understand - but what are the concerns you have with s=
him
> > > > > code that has been accepted?
> > > >=20
> > > > Maybe my concern is that none of the patches have a tested-by?
> > > >=20
> > > > Probably would be easier to get a test coverage, e.g. for people li=
ke
> > > > me who do not even know how to self-compile Shim, how to setup user
> > > > space using the product and so forth.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ~~~~~~~~~~~~~~~~~
> > >=20
> > > for the end product
> >=20
> > <nods> That makes total sense. Thanks for the explanation, let me doubl=
e
> > check whether
> >=20
> > https://github.com/rhboot/shim/blob/main/BUILDING
> >=20
> > is still correct.
>=20
> Those are the steps I use for building.=C2=A0=C2=A0 I then move over mmx6=
4.efi and=C2=A0=20
> shimx64.efi to the ESP.=C2=A0 I can add the shim build/install instructio=
ns to the next
> cover letter If you think that would be appropriate.

Yeah, that would be great. I'll try to setup VM for that purpose. I have
already a script to build UEFI enabled archlinux VM's, which I use to
test SGX patches. I can probably tailor that for this purpose.

/Jarkko

