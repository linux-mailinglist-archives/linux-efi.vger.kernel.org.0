Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7480D61ECF2
	for <lists+linux-efi@lfdr.de>; Mon,  7 Nov 2022 09:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiKGIbp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 7 Nov 2022 03:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiKGIbo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 7 Nov 2022 03:31:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F20140A3
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 00:31:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 31268B80E34
        for <linux-efi@vger.kernel.org>; Mon,  7 Nov 2022 08:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B861C433C1;
        Mon,  7 Nov 2022 08:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667809900;
        bh=56j8qVvttqhqmstQqU+jonN+Emb8+XpbTo72sKOmA4U=;
        h=From:To:Cc:Subject:Date:From;
        b=ftXDUnDVgW+C1x0rx6EkWBmJ75LdLSvcoZVaSSfrvotUGm8jh0FdLxvJUnDNCeMXj
         GcArHayPeF3Cw6XhOX/JHG38MvSonlj9dNx1WtwgweZIzSabSeZtgCAOERGLXOXbJj
         NuvOYY8JieBqJZbJnZUiUiV+HHN0gQ0DIO7VfFm14Krc4sHj0Dxo0990E6boAyzn9w
         ODkAW8U1sTkEmaqcYg25sWjXvyAv+4iRfksqBCV845k0sb2LdB7ipW7QvolsMYt6eg
         +klE6vSicID0TOJ6461VNdYdIZLv3PN7ACG/0bwYcgbvJ7Cj79eF8RVx0up83lEhji
         2DfrCdMUym2xA==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     dyoung@redhat.com, Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/2] efi/x86: Move runtime map sysfs code into arch/x86
Date:   Mon,  7 Nov 2022 09:31:32 +0100
Message-Id: <20221107083134.234918-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1167; i=ardb@kernel.org; h=from:subject; bh=56j8qVvttqhqmstQqU+jonN+Emb8+XpbTo72sKOmA4U=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBjaMJhGMxz9FvqGiDkmwKiAEx980cZCAeBY7DkB9Ty DLdOE9GJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY2jCYQAKCRDDTyI5ktmPJKGIC/ 9tlQunBY4ot/+4WQ7gaCkbe22c8kijqDd94/5H0GcUF09Qzcu153PTcLx8BpHeZXQ5lA9QzV0fErUh rWHwvbM7lJSH1qWDD5d+HUufvzm4RPA118j7qLyPCg/E1CdrTLU6juuAuwNG7pjikHx57j7rG1Nd2K GM8AE76AwQcHv9AmgMe6mwCS0jpORZPZUxvROOD57Dkiw7mLsOUW9WzBKhdxVHY02KEWe79W8O0r3s 0+Bj5YjVlKBQ2Orrsgw/V6x0AsQx0fyezM0npBdn4Jr15jo0MwISnYYZK57tiWbdNApUiuN7YyZH8h u9XF5ZyfKYOLphidwAzyyXjlBaiN7F+CPsyozxWE3eb14JH+DPITNoKK7355DfndhlNASjs4oV+BmE +PFBirwPzDhL4IxsICwM6nv4a2Vxr5gADdnfh3Cf5G6ija/p7vKAY824Fg1o3l8RRJMP5bP05C7ruR fsPqaE8grd3Q8JldOb3itKnFaH9gtH86T/CpFdmNXaB8Y=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The EFI runtime map code is only used on x86, so let's move it out of
the generic code and into arch/x86. While at it, clarify the Kconfig
description so that it gets enabled automatically when required (i.e.,
when kexec is enabled), and can only be disabled when CONFIG_EXPERT=y

Ard Biesheuvel (2):
  efi: runtime-maps: Clarify purpose and enable by default for kexec
  efi: x86: Move EFI runtime map sysfs code to arch/x86

 arch/x86/Kconfig                                          | 11 ++++++++
 arch/x86/include/asm/efi.h                                | 22 +++++++++++++++
 arch/x86/platform/efi/Makefile                            |  1 +
 {drivers/firmware => arch/x86/platform}/efi/runtime-map.c |  6 ++---
 drivers/firmware/efi/Kconfig                              | 11 --------
 drivers/firmware/efi/Makefile                             |  1 -
 drivers/firmware/efi/efi.c                                |  5 +---
 include/linux/efi.h                                       | 28 --------------------
 8 files changed, 38 insertions(+), 47 deletions(-)
 rename {drivers/firmware => arch/x86/platform}/efi/runtime-map.c (97%)

-- 
2.35.1

