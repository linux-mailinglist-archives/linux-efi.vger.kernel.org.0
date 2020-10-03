Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E9872821D3
	for <lists+linux-efi@lfdr.de>; Sat,  3 Oct 2020 08:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgJCGiO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 3 Oct 2020 02:38:14 -0400
Received: from mout.gmx.net ([212.227.17.21]:41065 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbgJCGiO (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Sat, 3 Oct 2020 02:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1601707075;
        bh=XRD1G/FKH5P14Qoexkz4KABtNAoyURyyM07p9s6A2yA=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=g55jZzqAXpsVo9RbgbGMro15/KEK4AFcMWrdbwImz473pZtOmJaiJwbz//1jX4CW9
         Qij0VWSkZKiofX6EHL6No0kxRzRb+qu94tofYJs0DxbjcYBEA9LyNd8pIuFiNfEl6V
         Stzs5swGlR/ESB2/krromLiah2I3ihqbn0ADvd4s=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from LT02.fritz.box ([178.202.41.107]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MvbG2-1ki3Gu4AmU-00seKf; Sat, 03
 Oct 2020 08:37:55 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-efi@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Atish Patra <atishp@atishpatra.org>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v2 2/2] docs: admin-guide: EFI stub to main Linux handoff
Date:   Sat,  3 Oct 2020 08:37:25 +0200
Message-Id: <20201003063725.8698-3-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201003063725.8698-1-xypron.glpk@gmx.de>
References: <20201003063725.8698-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:i+31IZulvm+Hkm7Jgc9slA5QQmVL8UwmQXplGyx3R1TkJGbBspR
 XPqhfjvk+xyIKZzg6xGtnym6LYGj2X/c3mml0ZtXvQELo7AglFu2XZuDPIWWAitvE8yDNgw
 84P5xxAjcRL80fFpZUmqUIxVt9IYKZSBnVteu54lr298LBb2oa7er5OvcTaVUgSnPMADJGo
 MA9ILHeYiCfEo47WlVY5g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yRmdQYnLlKc=:Bgo/dGOvyZPkoTfpEazkt9
 Mq8GzYXyQz+Oy0m3rCNm0b5Z8Yx9ctatfa8KzVu1YxGvr/7lLGg88dxNX7ksWz/SOHvZ4o6xw
 Cqbf715H1RvmSXr/O5IWQV0PpQEfe5Y111J085ZTRVqZBKqQghpXxyNe0cnr6VKunrePa0ZJY
 3hgb+oZl4joxQnHP1xBXhjuQi1AbNqZg130i9dDLz/eu4IiPxvdr6wvgqywEP1ZQMg9DB081P
 Ici7eRvEX/MrAnbYUqKu7/bycqRs4WTGZ+xueMmd2TJDJFLOKYLog/p8Dqy9Z8hGyTVIhnnyW
 PylafJUW3WcjSIrVb97waWsUdlZxjz7NDxvThFLhsqUT+Pvd54onHnwCmMpuLupgahC2JPN/o
 lLp8Yju2LqoeoRPjpNCVzZyiDFjTwe41+i2hE4QMmVt/7plCq407JxIqdS7RR4c5GaAN4D1JJ
 zrTQtTjj01+62+WHDF9wXjMjnVw15yaLemD/7X+jvCNg6mm46/CYQz8KRZS+Mv88nFXTqRALF
 9JlT9vW51bn9Nvj8L2HMdTv3CFv4y+9VYA8OcDhWwIwIcueks3dibaMRituDGzvwhriSXDgJw
 fqhQsYEeXHfTcImiz0+V99+3yePKcIPSj6YDH0iYOEcdNGfhBgiOTirG1QKl1yzXyoc6LC51l
 zF2ppOiS65pd0/Z9HTrtEs+DWdUe5labAI0T86H3/gQkcs6B6DIZBPfC8F1cIsqEsfRoKn+gg
 ooPXVx0s/vY8XHBMDFVydea77mvPCicDCb5eZzXi3VP5fqOmObJBeJ5tg3TLYhZyrQZgwbb/l
 3q6FcKRAV9PIp4Ammt2N8UQqI+5XqGrVSZZb904c17/6AwiAbhv0Ql7nKjOQ+aM5OBwAnf0Cg
 EHO84YCGdx1ccKy3EHnvtfLwpHxxBEiR2veTQgz+KOxjj2adkUvxkcFuUiwQ+C3APUhMCx1R2
 +r0YIjMTEQ8fdGXi7DRr2U5dKzj42MuvuAUBryBx0VolVg88+uFYPQsCMBVdLWpn1OKHNhUOr
 iQjYnMEIYv6DYGn6uaZUpKb/LwpcHvIHxW4cI/AKK8wfKASPts3ytwC5PRirceBStfhYPriYz
 sjbjt86kxYQePZGEIbHU97ghXOhwNtUl/JgIBL4VLwzD4cn1P2MILACsW6k4gX2MFa/m4TIyQ
 RqKtzI5HN9D9NIOLnYwodw09fBMmv0VPrne6BDi0DK6H8AQRxUFmTgx+qEJq8OrxFi+8CnTzR
 bdm3EpoI15W6Up1/dCwYXGh/BIDeNLYwYfe0cnw==
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Describe the handoff from the EFI stub to the main Linux kernel.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
v2:
	new patch
=2D--
 Documentation/admin-guide/efi-stub.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/admin-guide/efi-stub.rst b/Documentation/admin-=
guide/efi-stub.rst
index 4965dec48af4..669602ff4515 100644
=2D-- a/Documentation/admin-guide/efi-stub.rst
+++ b/Documentation/admin-guide/efi-stub.rst
@@ -133,3 +133,15 @@ described above.

 This option is only available if CONFIG_EFI_ARMSTUB_DTB_LOADER=3Dy and se=
cure
 boot is disabled.
+
+Handoff to main Linux kernel
+----------------------------
+
+Currently the EFI stub enters the main Linux kernel via the same entry po=
ints
+that are used when booting without UEFI. This might change in future vers=
ions.
+For a description of these entry points see:
+
+* for arm :doc:`/arm/booting`
+* for arm64 :doc:`/arm64/booting`
+* for riscv :doc:`/riscv/index`
+* for x86 :doc:`/x86/boot`
=2D-
2.28.0

