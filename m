Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA9E6920B7
	for <lists+linux-efi@lfdr.de>; Fri, 10 Feb 2023 15:21:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjBJOVZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Feb 2023 09:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbjBJOVY (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Feb 2023 09:21:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB84C302A1
        for <linux-efi@vger.kernel.org>; Fri, 10 Feb 2023 06:21:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5DF33B823DC
        for <linux-efi@vger.kernel.org>; Fri, 10 Feb 2023 14:21:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 548F4C433D2;
        Fri, 10 Feb 2023 14:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676038881;
        bh=JJI4P3DYRgztijiKHXZIYUeiWnxf91Ry9oLWBLXXy+M=;
        h=From:To:Cc:Subject:Date:From;
        b=Ct3MBh+HKX0Mec2CbnggYlgLyilpcrqXF2vlnyQg+MklE5Jd+c8UIY7rZsiFIWdJG
         NVf5rK62vKe8WRB/XBQPjyLyQi7z+Hm5ZmWMPg9V7rBZ/gkMgWXaCEQLmk6M/qvfz2
         wDCIko/KjR4OPjHUnkAqDIQ+jZrY2xVXi0pJTrSiJTQlYaKaQXVi9Z8r7lnV8yK79T
         +DZj0EAhHy2qDoxdZlc4hWbAItooL4dHubn+Rr+MS0pJTL9oHrXquj82Bpmw+nYlHP
         trCgW1KFUvDqOw9A0LEg12OATX832Qo3xfrKS7Gw/DIvWkPlWND2dMEqqH62wZP/0l
         g7sXYa2rR1kCw==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-efi@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Evgeniy Baskov <baskov@ispras.ru>
Subject: [PATCH] efi: Add mixed-mode thunk recipe for GetMemoryAttributes
Date:   Fri, 10 Feb 2023 15:21:14 +0100
Message-Id: <20230210142114.1861621-1-ardb@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370; i=ardb@kernel.org; h=from:subject; bh=JJI4P3DYRgztijiKHXZIYUeiWnxf91Ry9oLWBLXXy+M=; b=owEB7QES/pANAwAKAcNPIjmS2Y8kAcsmYgBj5lLZpLnxh4SkIyNeR7lYedd+eWkQtUBORs8Vg 0KPzl16382JAbMEAAEKAB0WIQT72WJ8QGnJQhU3VynDTyI5ktmPJAUCY+ZS2QAKCRDDTyI5ktmP JEfUDAC1lxGEgBSi+kXhkkF+BhTI4syfCGWwAlYDELGf4h81bAzDbxaXWSMuYgt/XLutigUuhiF vdvo7/2E0VKG5le6VCPh0/Oy9A5UZqGIOBZwxqNPcEOIhP31eF0N1AkVz0kfK5fNa2CCyNggIYF Dba9W0f2LgdM5vjo23wCq1yEpQ4G5W/h7J2sEkNb5C+hkFtXU9UkSZJSTtbaGuOo6jQJogrgKbo 4A6tWFncuNOoswZ67S7GCy+8uvR7fg6nS2A8dvU/ID9SW76EmH3qAF70IOGIOrtqOIGVy0Wn4DN 9SPSEInbPQ61CAL+QPzd3BcsS+enVQewUrV9j74LD9Me6A+aCMwiHv2mTcIfskPJimGFE1Haisi PNWVf3OlbwqdxY5I5NxMySo8IQN9V0aFKFeyCqImXnEoXfHdx9cn9kKZ0xiPPUv8XQ2bQKUj+fc wb1C40ycYwkBe9QSp4WSEyzI38itXIWZSrguWRx1Ufhdadx5Za2OO355HLCgPygjVZa0Y=
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

EFI mixed mode on x86 requires a recipe for each protocol method or
firmware service that takes u64 arguments by value, or returns pointer
or 'native int' (UINTN) values by reference (e.g,, through a void ** or
unsigned long * parameter), due to the fact that these types cannot be
translated 1:1 between the i386 and MS x64 calling conventions.

So add the missing recipe for GetMemoryAttributes, which is not actually
being used yet on x86, but the code exists and can be built for x86 so
let's make sure it works as it should.

Cc: Evgeniy Baskov <baskov@ispras.ru>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 9f8ded3de0381973..419280d263d2e3f2 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -338,6 +338,9 @@ static inline u32 efi64_convert_status(efi_status_t status)
 	((prot), efi64_zero_upper(file))
 
 /* Memory Attribute Protocol */
+#define __efi64_argmap_get_memory_attributes(protocol, phys, size, flags) \
+	((protocol), __efi64_split(phys), __efi64_split(size), (flags))
+
 #define __efi64_argmap_set_memory_attributes(protocol, phys, size, flags) \
 	((protocol), __efi64_split(phys), __efi64_split(size), __efi64_split(flags))
 
-- 
2.39.1

