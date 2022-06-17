Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B00154FC6D
	for <lists+linux-efi@lfdr.de>; Fri, 17 Jun 2022 19:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383377AbiFQRtF (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 17 Jun 2022 13:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383268AbiFQRtE (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 17 Jun 2022 13:49:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9C63F885;
        Fri, 17 Jun 2022 10:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EBE8CCE2CC7;
        Fri, 17 Jun 2022 17:49:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8A67C3411B;
        Fri, 17 Jun 2022 17:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655488139;
        bh=L+EzwOltouK8nUdGa9wbU0mrC3vtJYEMgjsrZg/zH10=;
        h=From:To:Cc:Subject:Date:From;
        b=Y0RuXmLVwLdAcg+kV9EuLRMyM3pRUY+9ubPjn1BxmRsIFBg4gGqCrI0xtK4nhE120
         v5eFjFnvAdPD+BdZx/tNLQUAY7vSZtgV5a05nkh38PGBMytKgQjw+dbb6/JpPyUY0h
         FQeFMbDlD3+X0bjcnW65wWHhcHOspDJo43IEca84drwUW3FUlYONKZZwdqWfLFEPeD
         RcAGDaNrNd199MHpFcYDILLyQaZcs9EApzbhU14Bv2dA5wZ3aJ9/RQyidl8Bi7wT3j
         1iQANgiEpDnqGH0WgBXiIXZfXf+7D8xPpX5kFyOKPz/tvdOkQFgoIcYwn2i0rCuC9y
         5/kiZ2o9QziKQ==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     keescook@chromium.org, Ard Biesheuvel <ardb@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        linux-input@vger.kernel.org, linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com
Subject: [PATCH 0/4] efivar: remove inappropriate uses of the efivar API
Date:   Fri, 17 Jun 2022 19:48:47 +0200
Message-Id: <20220617174851.1286026-1-ardb@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1926; h=from:subject; bh=L+EzwOltouK8nUdGa9wbU0mrC3vtJYEMgjsrZg/zH10=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBirL57L9lORYMR1QxTTNEh34nz/syvm6Wgw9/NxLvm m+80FEmJAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCYqy+ewAKCRDDTyI5ktmPJJ5yC/ 92wNyLeqc/dwBySl/hfwv9qIHlMdD6JH/3qt9gGQ401SKwDlChDu4bQvNKlWNl3IjAe2DMA8L/oAAK 6Jqy9COQJ3ecIgCHm4+nw+eWZ2ZcFTlni7MuydbfWgFrESYfcGVqETFbw5K3ko0pY+elGyWxlAyzbx mhC6F7u8ryG8NaKAL1q4ZHPzWKbvVNFQaRt5Vnzttq3oF/z38Vua3owIfC59uE2cJlJDX7h82Aqx3t BOz7W0lGn8yPdPHiuHEp3FAjTgkDHikm2oRTBgS56S8IuzI3OjdgFMEGd1KzoLEL1mjDa9EtK+i8m3 MkB0/QDvxkXAM7WTbCQGWC926voOD+9IRnebkc6lf8pgh9GcQD4DrZUQgNllq65BiJCA8ZmUj+Dxy+ ZbczZzosLVRbfh9OIh2MWpsFvJfjj/29tIlor3U1b55kWTTYZ339cezWZT2VeW7FUoRTjN87bXspLO 3Uqwu8JmeYZjuxzhqEPEJrzd/biMW0T/XJb37SYxev/MY=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The efivar layer is a caching non-volatile variable store abstraction
that is normally backed by EFI, but in some cases, might be backed by
Google SMI firmware interfaces instead.

It is mainly used by efivarfs and EFI pstore, both of which actually
need the caching and abstraction properties. However, there are a few
other occurrences where efivar is not necessary, or used in an invalid
way. So let's fix this up, and remove some impediments to refactoring
and cleaning up the efivars layer in the future.

Assuming there are no objections to these changes, I intend to queue
them up in the EFI tree fairly soon, so that ongoing work depending on
these changes can continue as well.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arend van Spriel <aspriel@gmail.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Gregory Greenman <gregory.greenman@intel.com>
Cc: linux-input@vger.kernel.org
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com

Ard Biesheuvel (4):
  efi: avoid efivars layer when loading SSDTs from variables
  Input: applespi - avoid efivars API and invoke EFI services directly
  iwlwifi: Switch to proper EFI variable store interface
  brcmfmac: Switch to appropriate helper to load EFI variable contents

 drivers/firmware/efi/efi.c                                  | 103 ++++++++------------
 drivers/input/keyboard/applespi.c                           |  42 +++-----
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c |  25 ++---
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c                |  96 ++++++------------
 4 files changed, 95 insertions(+), 171 deletions(-)

-- 
2.35.1

