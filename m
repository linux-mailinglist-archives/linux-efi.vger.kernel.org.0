Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEE56F7F36
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 10:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjEEIjx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 04:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjEEIjw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 04:39:52 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74C618876;
        Fri,  5 May 2023 01:39:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24e4f674356so1385831a91.3;
        Fri, 05 May 2023 01:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683275990; x=1685867990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5aRZSqqSGHolTlh1jtoDKdcPZUN/607EWF6b0DkrsH0=;
        b=AZK4dSGaMIFsre3ab92ohSTLZERw1D4UVGxEBRjOtKP6UhdmDSBcr8z0sm901npXrG
         mWUooB0uHfaLjnmx7bfX1yx+wRSHgQsx4tLIA4huIQrbAiarI6jvfGE1nfn/xSB0A89l
         t6mKGCVygg6b2/gLC4N6mWNU39w8dUQLO8K6lLO/j9eruFTh/Hmbg6SLuwv+pb6ySicp
         eexkrTwLz8PrhTPSZnAE48CBGL3lK5qeCNmkq0OLRWpZauERfD7pcXFXqLVgeGbx5j67
         3rLwWjyGlmZROMsmlX0gAsAHyAM1A+F83Nn4OTesBSFWvjv2aYpVxpSm78AGf0YEnIta
         b7OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683275990; x=1685867990;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5aRZSqqSGHolTlh1jtoDKdcPZUN/607EWF6b0DkrsH0=;
        b=Ja43UoPVcSP9LfPeihJ8aylyudcP0mPEVC+daMvzo1jyt2pA9CNh3Uv/AIZkJnCnqu
         iKJTT+MOoIEtrMkuXj/iDgi/dyY4GYQayGf6cbRjvhObvEPZF2meQ/98/hNM4IsKE+qv
         eaUQCkerGjCIs7gl8jQvYbSOTLZuiSxd/YeLk2mp9sjAbKJ+YFIau6kCjFfmHYtfVE4C
         aJDkxZoOW0pkcPzk2LRfpGbWsc6Gbc99cbU7rFl5+8E1PVQ+WnOT1diT8w0Ci5A6zNHm
         22IVCkVymY8MwGfugPG/XtUX+Si0VbP9VbrgY5o/q2FIKim6l201awmsjwJasZiyvkLF
         wrVQ==
X-Gm-Message-State: AC+VfDxwZGlsWcBWV9e3+g7i2h6nQGoBBOiTsS7Q03xfaWu7YozSd1YP
        c9FRWUwhW1nAGSD0ybKuAYU=
X-Google-Smtp-Source: ACHHUZ4UH5k0im9tHcDD0dnFM8xRvkntB8xfaghRqc4oSAV95zeDV+5tHiAc0U5MZUzLoIsVrIWOYA==
X-Received: by 2002:a17:90a:e645:b0:247:35f8:81d2 with SMTP id ep5-20020a17090ae64500b0024735f881d2mr699164pjb.29.1683275990015;
        Fri, 05 May 2023 01:39:50 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-14.three.co.id. [116.206.28.14])
        by smtp.gmail.com with ESMTPSA id v13-20020a17090a0c8d00b00246b1b4a3ffsm12895140pja.0.2023.05.05.01.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 01:39:49 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 9BAC3106281; Fri,  5 May 2023 15:39:46 +0700 (WIB)
Date:   Fri, 5 May 2023 15:39:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 00/14] x86: Trenchboot secure dynamic launch Linux
 kernel support
Message-ID: <ZFTA0kg98XxeP2Hh@debian.me>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8WmKHbH6zHIoE+UF"
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-1-ross.philipson@oracle.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--8WmKHbH6zHIoE+UF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 04, 2023 at 02:50:09PM +0000, Ross Philipson wrote:
> This patchset provides detailed documentation of DRTM, the approach used =
for
> adding the capbility, and relevant API/ABI documentation. In addition to =
the
> documentation the patch set introduces Intel TXT support as the first pla=
tform
> for Linux Secure Launch.

I'd like to apply this series, but on what commit it is based on? I
don't see any branch containing this series version in trenchboot tree
[1].

Thanks.

[1]: https://github.com/TrenchBoot/linux

--=20
An old man doll... just what I always wanted! - Clara

--8WmKHbH6zHIoE+UF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFTA0gAKCRD2uYlJVVFO
o32tAQDw4tpfR8Ba+q25skoHxrAI3+hK4yJ0HkwQNobWGCAvRQD/Yq0tZ28KagpK
QjB72gS5Kql0kR9GkjUSvUZRkt138ws=
=ApTD
-----END PGP SIGNATURE-----

--8WmKHbH6zHIoE+UF--
