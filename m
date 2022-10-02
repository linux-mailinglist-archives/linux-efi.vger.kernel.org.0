Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE9F5F23B9
	for <lists+linux-efi@lfdr.de>; Sun,  2 Oct 2022 17:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiJBPAs (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 2 Oct 2022 11:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJBPAr (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 2 Oct 2022 11:00:47 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A492B1A1
        for <linux-efi@vger.kernel.org>; Sun,  2 Oct 2022 08:00:45 -0700 (PDT)
Date:   Sun, 2 Oct 2022 17:00:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=damhet.fr; s=key1;
        t=1664722843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=fEDbmHSV7dAxnRxQ35DlDRySZsusqyi9n+vCBBy6v8o=;
        b=QwL42SHy8h/J5ZzOoJzZrOsU/zWTL8C8fbJRA9csnMDwoDnQVTXmsUHaYsTM/CFR0ezEJ9
        HqskWkRG/xWccOTXNHUeLeym+y49kwcL6w4avwm8f3NRheKsiUHzOx2yT+vJC9C7WvsJhO
        ELEHV/Voq9oPrFWOqrnMHA04QGApjFs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Antoine Damhet <antoine@damhet.fr>
To:     linux-efi@vger.kernel.org
Subject: Disable lockdown while keeping SecureBoot enabled
Message-ID: <20221002150037.ad3tgbllhvt6zwwy@tartarus.xdbob.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="avoh4quechsivcxu"
Content-Disposition: inline
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


--avoh4quechsivcxu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Since `5f56a74cc0a6d9b9f8ba89cea29cd7c4774cb2b1`[1] I can't have both
SecureBoot enabled and lockdown disabled (I need to do that to allow
undervolting on my intel laptop).

My current bootchain is:

systemd-boot -> kernel+initrd+cmdline as a unified kernel image and
signed using a personal custom key. I don't use the shim loader.

Until now I disabled the lockdown by setting the `MokSBState` +
`MokSBStateRT` UEFI variables to 1. Now they need to be volatile.

Would you be open to either add a variable or a command-line argument to
disable the kernel lockdown while keeping SecureBoot enabled ? If so
what would be the right way to express it ?

Thanks,

[1]: https://lore.kernel.org/linux-efi/20220920153743.3598053-1-ardb@kernel=
=2Eorg/

--=20
Antoine 'xdbob' Damhet

--avoh4quechsivcxu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEArm1WbQx2GmOsfF83AmjLzzljz4FAmM5p5EACgkQ3AmjLzzl
jz4AJgf/eXYNtgrFxcFyZbLswxERvOm0dhswcxG35FKRPPmm2QNXemsf+c7UUi66
4CE4+CRonIK1flF947Fts6ofU0xA9/D1Q+CfpdIdB5kzX23ziZGbLy46hpzlfjjn
199qVre6s1al5hEJKK17PkGaAgoZiM3h+jjdStokdR+osqIXWR5jCdPa+D4Sgrtg
EmFQFhxt9IwTU8b9VVnWwos8+VSjn/gp4t40sAi03m4GqoR/KjXWRGjP6rfU+OBh
p4CUSf+stoQhvMSnAmiz3Wlo+fR3r2/+4cf0sMpikP392KK7tECq5QB8nodXDXtn
IFdmMTbgOJ8KTAU61OVhYCemwF4wpg==
=/GJN
-----END PGP SIGNATURE-----

--avoh4quechsivcxu--
