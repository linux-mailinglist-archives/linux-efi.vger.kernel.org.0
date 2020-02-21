Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83C30167C7C
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 12:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgBULrd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 06:47:33 -0500
Received: from mout.gmx.net ([212.227.15.19]:53831 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726909AbgBULrd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 21 Feb 2020 06:47:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582285642;
        bh=0PtZwcFUAPJb3906OUvjv5XTCsimZRw8glwcqJsmbPk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=kL/8mb1GGsNLC2675g1cnHzoPqKrc1eKDHH4Gbm3F7R8xX4h6Rcprg3LcfCxyD4kw
         lds2FQA3a3adqU11Vzf+48YUfvsn9J8GOXvTxwXQ50A8JTjzcoztAhu3AEvErCCTQP
         QkGtwxdXVbO2Q18jokBYhaCgg808eC8xVyzzwo9s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.160]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mqs4Z-1jr8zD0IQT-00mtkm; Fri, 21
 Feb 2020 12:47:22 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Dan Williams <dan.j.williams@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/libstub: describe RNG functions
Date:   Fri, 21 Feb 2020 12:47:16 +0100
Message-Id: <20200221114716.4372-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2qSY/f99+lAr2378TCeJToe4Uz21ROxHasAsb9FK0xAlqp3txJN
 7uuxnsjLrcxD9sim/cgZHKJeIRJW0prVPk5b6NNw2UojlptliHldulNIunKIrIFJLvYBlP+
 +lvBLsW3eZLuEl01i2PQwcP5OglVi85cPIHh8+N4gUuELSzBz5sVzDX5WBxn6e3UDY/urKb
 Yew51cUapCI+XAbwCXK3w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UT27+fA04vA=:BrTFdPlpzhIOhT6ZLUhlta
 Yx/SYsuZMFB+m+atrXvGCpCA+PRBhKZzQcoxb9f/p7B4a6czTI+s2yYu7ls3Z3bkRAfhobqFR
 ospU5wDzcp6siiyeA18fJjqnwZPK7W5yCBFmra8xsScohLdWYDIFt2KcaY5IKXlyuqyVJH8pF
 bPyAilUAGlmRQN6tSWyevEU+PFRz+uScx07WuWFCOsWSejh+PxY1VFO0vyl6LqWiPEjbYlftx
 0QBkyEUu4JMfxjhDcH05/Y5nlrn9dfMvhUX/+i6YzGpiGOsTgLAgANQ69fE9u7qXfFx1Rg3gQ
 2C2czx7QqGkMSBKV9EXg27qi7s+fSL2nAt6IpppyResjJaNzm03dNHbTdAGnkZMWxmIBqcN5y
 bcdfGU/YSOSrVQPs+KJGqq9RgIXSlm/HPNbw0wyQGSWctBsM+o7nC7t/wpQwtlV6RcYVqYPEB
 MFgj0ugj+yYux7QLxT4lLbNwwr0/V8vXDfuZ0zyMMSBa6Uhk8CvOYWQyk+oIznle8HaAiQi8g
 o7LH3xmlTfw/v067nyevB1AkvBMTuCm++Jk3r4XEdpaMLupFRm8yfXjWZJzbXMSDha1Iz8m5y
 pRtIkTG4qU9wolzjSSzGOek1ZiXSzonbBsSHzuWyAr8+ZY/K/IuFFQZWkyXMJaxmoCov5buTa
 wXCqpgrvnJYV05dvbMAesUy5lIXXsJWifX+9byo0FG6Uhk/o3vey7Oinln/v7QKM4ZVK65SaV
 P0RH0AYATcYu6m+IOX/4j9xc5EaQpEMBHQfCt2+zoThRhA4ru1CmQBrwMxlknHIqArRtYG4Wa
 wj5CxNWnjJwiiJHYpvNuOwbfdcCF5F2O6ge5xfa+5xroUYJczk5gVPRHFhEzBnzr+3moc6dwp
 5KpxhrcOmLZkwyPoqcIqvokka3hVWcv37pwR07B3QeIjHH9/4buzLhkKmW+TPoFoAOEchxqCa
 b2unCMktSvvW7AYffIqdZ2puUbAdNj8yqlcM7lAak/tT99ZWXJhccx+EeekHOb0nMvyIv9gRk
 O9mA8Dm+8Y+vYxgaG0idTHevrXR2C5omcVoD4+pOYrMtUNVIQ2bGLOM2KGId2Qp7pfT/mtFJq
 P1S+rGYnN9iR3sGd7BsJAmqyTXN53GqBQ6aOrGDP8b+xoLjabpnx7t1ZMiLbW+nIlcD65hNil
 T6xu36oE0lD0v3Sv1eXsbva3CNDfUfRfoaI/Z4JI/w/5SzJEzohQWGyKzMtd2oXif2bkaxh48
 55ppqc8To52JYJxkg
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Provide descriptions for the functions invoking the EFI_RNG_PROTOCOL.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/firmware/efi/libstub/random.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/firmware/efi/libstub/random.c b/drivers/firmware/efi/=
libstub/random.c
index 21e7e9325219..24aa37535372 100644
=2D-- a/drivers/firmware/efi/libstub/random.c
+++ b/drivers/firmware/efi/libstub/random.c
@@ -25,6 +25,17 @@ union efi_rng_protocol {
 	} mixed_mode;
 };

+/**
+ * efi_get_random_bytes() - fill a buffer with random bytes
+ * @size:	size of the buffer
+ * @out:	caller allocated buffer to receive the random bytes
+ *
+ * The call will fail if either the firmware does not implement the
+ * EFI_RNG_PROTOCOL or there are not enough random bytes available to fil=
l
+ * the buffer.
+ *
+ * Return:	status code
+ */
 efi_status_t efi_get_random_bytes(unsigned long size, u8 *out)
 {
 	efi_guid_t rng_proto =3D EFI_RNG_PROTOCOL_GUID;
@@ -38,6 +49,19 @@ efi_status_t efi_get_random_bytes(unsigned long size, u=
8 *out)
 	return efi_call_proto(rng, get_rng, NULL, size, out);
 }

+/**
+ * efi_random_get_seed() - provide random seed as configuration table
+ *
+ * The EFI_RNG_PROTOCOL is used to read random bytes. These random bytes =
are
+ * saved as a configuration table which can be used as entropy by the ker=
nel
+ * for the initialization of its pseudo random number generator.
+ *
+ * If the EFI_RNG_PROTOCOL is not available or there are not enough rando=
m bytes
+ * available, the configuration table will not be installed and an error =
code
+ * will be returned.
+ *
+ * Return:	status code
+ */
 efi_status_t efi_random_get_seed(void)
 {
 	efi_guid_t rng_proto =3D EFI_RNG_PROTOCOL_GUID;
=2D-
2.25.0

