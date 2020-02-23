Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AF2B0169A69
	for <lists+linux-efi@lfdr.de>; Sun, 23 Feb 2020 23:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgBWWNd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 23 Feb 2020 17:13:33 -0500
Received: from mout.gmx.net ([212.227.15.15]:39539 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgBWWNd (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sun, 23 Feb 2020 17:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582496009;
        bh=7aF+9AalTCdfS+vpKbzZPW44vdZ1tp1jXR1yYEcXBFE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=H4trSBHl7PwH385Hd2FNDd2bLFL7rpavBO+jI9Qj9O/Cxzyl6wd9pwd+SvJbcp/kg
         Q2olTNXXaIZy28F8a+c33SVGi7SAhEHSgbegxU6IbTN4IHR2mQpYbqieQ7wCsGydfo
         GrtmY8DG3WjNTPol7w4rZnlDN9XPm+8ROtKr+GXs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([84.119.33.160]) by mail.gmx.com (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1wq3-1jYcAz30rh-012DSw; Sun, 23
 Feb 2020 23:13:28 +0100
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi: don't shadow i in efi_config_parse_tables()
Date:   Sun, 23 Feb 2020 23:13:24 +0100
Message-Id: <20200223221324.156086-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nigvyDmZdjk7I3PSnXcXZTauKBprqzPvXojHn7qawH8bjs5J+hr
 l5OQSj7O2w6RibwHk0nEfPSIGec56uacl46t8DaQDI6QfkV5DXEH4hUbZTWRguFcDdk+q3Y
 KcJim47zrVS+v6QNDzaRpYR7kYuZLHvUY4dLh6QddhdGMsQQWhtc+ogT3rc7bbXznI0wOhw
 Hz2RujCg1OnbQnTJJmYtQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:91uTEu6FxFM=:O5CDhSjasjEcqfxQ4TpEv4
 v4FrIPaCs3I7cLxqnBxWnLmwfLuMMQYIXTRN9LCpcOJjJO1z7xAW7YrBj5gETfor2brBqZ585
 3EmF3SAiqD6VfiMfT9miU9a+6M426iH6nZeBzvnjBh7e83iJoWHFMkdUyVf4EwiSQkqDrUmhr
 glvtTg1xSFhBN9crfBm367pdHlI8EanVcOSly3tUyoOzZh/vgHqj8a2TYU5JG9T9MeHiBMCyQ
 AWPWiZW4ggiRJc8mSnrL4JCVEp4Y1+sMN6Ff5irgNgRTnBJ9krBHkMxbTu5XOy8RAbCM+p/gp
 pD4Ylk7WdAAwiIazYmBQZVkPlJvSA3Q29pTqtlHzXIPHZAfD9ayBIAdCOJCvXOgCpQJ6KrAUM
 TFuzTzqFFGxzP9DJaxUu4oUic3SIgLEJOBewNyHpeRTyeARmQ/7/vNlRBm4Y7OGtsWgZqfMjq
 fhlYX7R0bP0io1MBz0e7cyRQin0LEkJMo3JHtdyl4zHxFz9uJkMaqa0l4UCQBEVmjcCvWqeTn
 7TgvXn7rPBclquFiEUVr+os0xmewwICEg+1x4FTio6YMw2YkR24IW49RXEggpXmP/WsWTVlhb
 e8EcdYr9wyjpQLku1Cuv5cVHZS4qGqpzJzA/PYZ+qsmCI4/QH9Zfl+//8BjmIJlLDqtWrv+3B
 KuO2t2HRcA/3dCHxA0MjFNLS3p9VoJGj5sxjKxn60eM5d6GefREIkcdgEA6HKIAwCCcAWFn6i
 t+GswjkRh6Ku4T8bKlXYZJZaNj/QNSCIktw2wqa7vByjSsstPHTh1XE5vGbz0LKdakblyOjDo
 9vCxnNtXKuRZiHae5IgRopIBGgn4ulcDbwRAMrlalAmoRIle0MTd/FTlmRUOMUt/VBQKDtpRK
 lXFHZCkATkPbgiWBfomA55yvpqAXNlkP2moiCD6nh5mb0/paUkVqw7Nb7pyGD0g0Mbe5HMayO
 ibrNIaegtJnLu0VDDTfWfkrerEV7zKuJDWLKqW48YlYW1qi+OulwXFZK4xXpfLpO8ZVzSeOmj
 B6Gd01jEGywxkKrc64Pc+CFPoOXff9PtQyb8RnrS7oObY5J+Y5sgwGpQcF70eq3SskEndhogh
 3huei0c3xx1g+TlPzRSawuBCODqY3e1fhAy+xsE25sI4CamWPEQ62VzMaNuuUY/g93mJP9V/s
 QPTHzT1g7jK7fU3HOJdrc7ZEc+hKVCPC8TiXCUUp4nVJlKLVC12/A0lO6aQ9L08vOdCAbfHtg
 7gMXtHZaSoXBPZ/tv
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Shadowing variables is generally frowned upon.

Let's simply reuse the existing loop counter i instead of shadowing it.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/firmware/efi/efi.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 69a585106d30..d0c7f4c1db31 100644
=2D-- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -553,7 +553,6 @@ int __init efi_config_parse_tables(const efi_config_ta=
ble_t *config_tables,
 		while (prsv) {
 			struct linux_efi_memreserve *rsv;
 			u8 *p;
-			int i;

 			/*
 			 * Just map a full page: that is what we will get
=2D-
2.25.0

