Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E9225DE7C
	for <lists+linux-efi@lfdr.de>; Fri,  4 Sep 2020 17:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgIDPum (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 4 Sep 2020 11:50:42 -0400
Received: from mout.gmx.net ([212.227.15.15]:46143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727784AbgIDPul (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Fri, 4 Sep 2020 11:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1599234634;
        bh=jUo1rcy8Vk2NuZDY7J5rwMK5KzvoLjBx6pfXZJ2n7Ts=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=BoOoqmq8X8mImNpc2Qxhh4W3343M4PBod5v0WS+79D/YHOu+NJ4lLK/39D8GnUj/2
         r1e+otD0HUauwi/LH0zgZPM0rKX7tlS8VlRqdEASUnnmE5GkorbhYzCCXC4UKirpKP
         ffX7LEJb7SSy8JAmUnKD0CNAzHF/TAL6gfXQE0k8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from workstation4.fritz.box ([178.202.41.107]) by mail.gmx.com
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MWRRZ-1k2s6s3RPP-00Xqnv; Fri, 04 Sep 2020 17:50:33 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Uvarov <maxim.uvarov@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] efi/libstub: DRAM base calculation
Date:   Fri,  4 Sep 2020 17:50:25 +0200
Message-Id: <20200904155025.55718-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:doqmB75RmQWNmTYciFl4XKtt9DbYeZi24qbKJZtWpVckGRC+xkp
 C2aj+6lhw2Csq6CtdQGvwNc+69X52a4l1JQwun8QOcPFy0GNT5S5QwYuzneTFVYLS/vEF0H
 Eo0a6wOvY/caOT+e4sEvnG7/k3gQGvVYiFjewgJa5WD2ABQ45NipTekj2F1fsSfOyIOC0AF
 TzrRlmSMs4kbfTUyshv5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SWwrOPPkoRk=:q29LpSorYGyKX0iflRUA06
 JME5mWcahjucKCi3cUm2cmJX1qdWbg6CSmFLtWLhbGAfru5lGpLIqtW3txlBltKZh2qAab0OB
 ODstMPG+W2T5lwXalzZEghXAl646l4pinyacgC/8tnWkw4zE3u7Xm0+RkRB/pmfBpQe8VkGh3
 GfnHmVgVmElH3zQm9VwejUOlYwT2NeU7ST/Rt8xQOxI9G2wYoOuOgJF2FU2Fw7cYsp5LuMXyr
 5sssYuAxtVPgsBDDldR+i51xKXdwDRzc3E3Zqt/DaQbAU8Dbv84E/YpYUlC3jU5n0bHsDmSrq
 YNavxuSHbi0W3UxQ+Xa4XQ+g9tc9buSw5VdsJb2EFoRO64BjJnFzWLV5MNAWoc2Jpmr/Lv3Jl
 4/H8e+kmKeotR0q/aTEz5kYtJhueJvIg7Wtwi+hl0nbUDb4o+LknLh1zDBw5NPX4PNk7NyH6I
 /EWa+9wbnWOzMiKRx5xwJ+F3wlL/eYheHGznQR3R5vcG+Koj2AJ8DZovjOqtxA1+6cA5bXXpI
 FpPSHjpZ2pMSRteb0EkTk0hL7JkHavs76b9lRzbOLl6vgNyYOmy2JLxz5/xS6Y8d8RfGHYMZD
 hBgQi/ocaOAD1PfpHkeiH+4HnXM8w2oNjBY3b9qskQN846PAQkLKiwA3wsXbaO7wcdUWML4MY
 PCY2nnqI3HD0zj3Mnbxx6eO2qSJBHNxqKgNW8A+h2Oh+kGOXWVNgXMARgyxAik+3ApwZWkahx
 krT5DhXadToVv6yOsvqHI7QpU2IPM5s0fi2gx1OrV7nxZOsvv5lwuWzjCRcpmcyCz3EvSbrMM
 cOLJwR7OcopuFb/ttL4ZFCZAQlfk3B/qyN6py2mO5yWL84+921Od/LD0kgqxG3Hi3aP/Pm816
 ZHYj9cUIge7TzimWYnk8nsxic3JKVFbzNao2wi6AFViFL/UW6ADWNCX8UhniRHTxK4w+i9EvV
 8+l09LXNhyOC3OZQOfCKtfaQ4iKoXEvKtLOsyzfc5ORw3cTcsVhrBxtwmu/37/fqgYmdDfJ+X
 kMESqzhJRjbIFin1Q5Avma6/yfC138l0K7e5PGGvD4WSmtj90rOy0pflV2PZ+gPyRp5jx0Wuh
 TuJmqPTxZzIADNgWCxEaCsZsizsJJtgtUGB8ihfCapRqLzmNZlg+W/a3rKcA56ak3TvF6zLtW
 yCEgLJBe2GRLXL29zN7Snl+z8HjRA5K00Ba845grDmWfzpMa0VEVb1m08hA1+apmjpZYzewc7
 TUIA6liQdeiDRsNVDyIYQJIVcAFy8YLXQzCi3ig==
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

In the memory map the regions with the lowest addresses may be of type
EFI_RESERVED_TYPE. The reserved areas may be discontinuous relative to the
rest of the memory. So for calculating the maximum loading address for the
device tree and the initial ramdisk image these reserved areas should not
be taken into account.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 drivers/firmware/efi/libstub/efi-stub.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/ef=
i/libstub/efi-stub.c
index c2484bf75c5d..13058ac75765 100644
=2D-- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -106,7 +106,8 @@ static unsigned long get_dram_base(void)
 	map.map_end =3D map.map + map_size;

 	for_each_efi_memory_desc_in_map(&map, md) {
-		if (md->attribute & EFI_MEMORY_WB) {
+		if (md->attribute & EFI_MEMORY_WB &&
+		    md->type !=3D EFI_RESERVED_TYPE) {
 			if (membase > md->phys_addr)
 				membase =3D md->phys_addr;
 		}
=2D-
2.28.0

