Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2626B5F117A
	for <lists+linux-efi@lfdr.de>; Fri, 30 Sep 2022 20:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiI3SVa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 30 Sep 2022 14:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbiI3SV3 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 30 Sep 2022 14:21:29 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF28A1032FB;
        Fri, 30 Sep 2022 11:21:28 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2D4083200A18;
        Fri, 30 Sep 2022 14:21:27 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 30 Sep 2022 14:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1664562086; x=
        1664648486; bh=e9mWRDSbNU3lBOaLJleKvf4YDJLq5iVN7Gaa45dLAu0=; b=s
        nn98HHSNuhi3ixoc4JBKtRoSarpSwIzv8QIzY/HjTivpnB/cRuiJasWAdzvVscHH
        Bd9Ub77cyHSSJv6idIOLFQy29F7Bi9nZtsNdRlvxalXLCeMHrlLWgyxDVsqJ12QB
        myHVwnJVouWzicw2arC2kVRHxvKimqRA19NOlJ6oK3E2w197E0dBgKB7ZYHB9sU+
        cEc1FdGRenklW5uWtWpSCnTJ4kD1Ytx/mMsB0ZvwBQ+iyFQSGxB9HvIyvCHx7gbh
        kPf5QtAGK3vuxHDPpFr3ixV1f2gy8kjf3wrMUZPa1ybRk+JQ8NcBbY2U/yD+vEBm
        2WfJi2sr9XxgVv8PsDwJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1664562086; x=1664648486; bh=e9mWRDSbNU3lBOaLJleKvf4YDJLq
        5iVN7Gaa45dLAu0=; b=kf/2V7MPo2jv5ypQKwCOo6lhzcB3nNQa7uLF0RCb9APA
        KnsPi7pJWsBkDd+az9ituznaWkb7XeJbxCTnh2jsQCe1zwynwd+Jjdrwg3ZMOfbl
        lAzZvNRz8i7qsAgRZVTLHboT+S9OgaCWRuo2+C4kDbc38ueMeaWv68gZy3I+6xFd
        SNBHdo2PUWkR/Jp+DVt6qi3ItjQ422ijUn73n8DhD5kv50mZENuC5NHOlwfSXBeO
        kUG4htEut87siYWHrKgkqLaYxACOEY1ZWA2gsEjUvBFwbdTGaWRJ203EAPb8bbv0
        NE5D4cWWfztws0DayP8I3DkYA5QpUuq/479k5kcu6g==
X-ME-Sender: <xms:pjM3Yy1bOwpmfWX5MHksDyS7UNZgBQpurhgAsmI3hK9dt-p5JIpQlA>
    <xme:pjM3Y1FcogrxVcemiCrKdfduvqVT7h4OtYuWo_mlAdH9IkFPSZb2GlHwjlVg2YHe0
    Be4JOrMJLA_dtM>
X-ME-Received: <xmr:pjM3Y65sHrbJ6fCq5Fq-eFxTnUbybRj2kJ1FfeZJZTYu-qufsucyuv-aryDv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeehvddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpeffvghm
    ihcuofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinh
    hgshhlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpeduieelfeeutedvleehueetffej
    geejgeffkeelveeuleeukeejjeduffetjeekteenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhg
    shhlrggsrdgtohhm
X-ME-Proxy: <xmx:pjM3Yz0G5Dl8RfDYkw2VT1gvrfZpilJm0NNWVZFq62fI-k74NefQaA>
    <xmx:pjM3Y1E6MWYK4NCfHsk-hrihdpx-MitRgtGt14AJWTjqcBUCRyjiVw>
    <xmx:pjM3Y8827T74jAcnQ5YJF0EW_JAvNV6p7gLw4hOo96zgn0OcJim3GQ>
    <xmx:pjM3Y0Awq0tMzu9n3UD5bdBXVJNZ5newPsKFaOu4nv4TdbmzkrayuA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Sep 2022 14:21:25 -0400 (EDT)
Date:   Fri, 30 Sep 2022 14:21:22 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Support ESRT in Xen dom0
Message-ID: <YzczpIYop5olD4hj@itl-email>
References: <cover.1664298147.git.demi@invisiblethingslab.com>
 <5649176eacda434267f68676f1733d06c572d19e.1664298147.git.demi@invisiblethingslab.com>
 <CAMj1kXEs-o8jvNqRiW+Ue2i52RBgg4iktg8UONCACk8-Gx4XXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rkGwejpOEGtuhYbs"
Content-Disposition: inline
In-Reply-To: <CAMj1kXEs-o8jvNqRiW+Ue2i52RBgg4iktg8UONCACk8-Gx4XXA@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--rkGwejpOEGtuhYbs
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Sep 2022 14:21:22 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	Kees Cook <keescook@chromium.org>,
	Anton Vorontsov <anton@enomsg.org>,
	Colin Cross <ccross@android.com>, Tony Luck <tony.luck@intel.com>,
	Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>,
	xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Support ESRT in Xen dom0

On Fri, Sep 30, 2022 at 06:36:11PM +0200, Ard Biesheuvel wrote:
> On Fri, 30 Sept 2022 at 01:02, Demi Marie Obenour
> <demi@invisiblethingslab.com> wrote:
> >
> > fwupd requires access to the EFI System Resource Table (ESRT) to
> > discover which firmware can be updated by the OS.  Currently, Linux does
> > not expose the ESRT when running as a Xen dom0.  Therefore, it is not
> > possible to use fwupd in a Xen dom0, which is a serious problem for e.g.
> > Qubes OS.
> >
> > Before Xen 4.17, this was not fixable due to hypervisor limitations.
> > The UEFI specification requires the ESRT to be in EfiBootServicesData
> > memory, which Xen will use for whatever purposes it likes.  Therefore,
> > Linux cannot safely access the ESRT, as Xen may have overwritten it.
> >
> > Starting with Xen 4.17, Xen checks if the ESRT is in EfiBootServicesData
> > or EfiRuntimeServicesData memory.  If the ESRT is in EfiBootServicesData
> > memory, Xen replaces the ESRT with a copy in memory that it has
> > reserved.  Such memory is currently of type EFI_RUNTIME_SERVICES_DATA,
> > but in the future it will be of type EFI_ACPI_RECLAIM_MEMORY.  This
> > ensures that the ESRT can safely be accessed by the OS.
> >
> > When running as a Xen dom0, use the new
> > xen_config_table_memory_region_max() function to determine if Xen has
> > reserved the ESRT and, if so, find the end of the memory region
> > containing it.  This allows programs such as fwupd which require the
> > ESRT to run under Xen, and so makes fwupd support in Qubes OS possible.
> >
> > Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
>=20
> Why do we need this patch? I'd expect esrt_table_exists() to return
> false when patch 1/2 is applied.

efi_enabled(EFI_MEMMAP) is false under Xen, so there needs to be an
alternative way to get the end of the memory region containing the ESRT.
That is what this patch provides.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--rkGwejpOEGtuhYbs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmM3M6QACgkQsoi1X/+c
IsFLUA//apV6j+1dncTlLgNl3AH30fnqZeCd+rz5EobZ3RLvMQ/Py7QYzqIZ8jkW
bhrWcNj1EH+0WcGME1oKob9/OEjEg/sb9WKXvQqvf5Wm9wlM2bzWrQrBSYyN3epM
/qeVHH4JWvze6WDUvcESiDUkUHS2iqkUflTAcU4ViAwo4fYIQWoBgKphI60ZAshv
IVZiL3tRQAO3/a/iyrl6JMWuPBE0EvM8AJznohdzgelrg9OgZxy2Mk7iQS5fiB9W
vBTWOBeQGlakoecfOZcKQmu7d0Rmoe5SJW968A61u6Aou/FQWYDzWyRyvlu12fVV
r72gpf2QZzaZuP4xyf9I+ezZ+yvs67eL7dARnmdbgABqyYi/Mp5cIxcN2O6us/I6
LD/e3vQJ5GdI3cHSOo1pjPh3obs9MpJbOfQ/eqXKajjWiamBZ8sHlqj14BGyTMvT
Is8+7ppdvQV6wcEs09akZDbDxB0e+bhZdFE69MoLzCrnW9qam9rYdGzsfkWNSdYy
OAFpjW+YSyo0zNPbKJALRouTPyshN/faRWV3pFEtNZQv+tWzmNunly7Q23bA+XIB
8UHv3qUvbaYXXeNRkhUt0W3gXF1gcWmx7I9sH+cfU4MpdFY8fXZc80KsJuxJPG5S
YcDiShwAhGN7nF33xN3HAOmx0qFQcqKhqVq+dXFctiXKYKsIXt4=
=SfaK
-----END PGP SIGNATURE-----

--rkGwejpOEGtuhYbs--
