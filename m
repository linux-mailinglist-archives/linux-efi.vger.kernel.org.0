Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F063E7CAF
	for <lists+linux-efi@lfdr.de>; Tue, 10 Aug 2021 17:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233250AbhHJPrR (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 10 Aug 2021 11:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbhHJPrR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 10 Aug 2021 11:47:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCEFC0613C1;
        Tue, 10 Aug 2021 08:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8qYzDOt1JxpJ/7Vxl0cI48aTbAQ1I19+tYVtQ/5njAI=; b=SWlWS+kKKV+UYcEf64AiWOybxt
        o1/PsAH3YzMVUXR3T5HQKj7SlrCIvNYZhEb9xIcRm0t9yP4RCHZm7yX8TCUa46o7fKp7g1PNgE5Tu
        V0hNkaW5BNLLf59+YibRiGVa55hWQZHE10sbPDk3509Y/gMM13jDo/kPnQpZ5nQ8chLLi2dWSGRAx
        v1dhQcz829jNYsyedEX525mR0R+BayL+8qydSzjdvVYgX32o510xvYB2xJx/y2LLclwalZwQ7ViLD
        ebzKx/wsf68ss89PFynmLakvXXBeW24tyOpi1yHQMRiSF083zFJsCHe82Karldqo2hVpa4HVkuUSi
        88olwXXA==;
Received: from 089144200071.atnat0009.highway.a1.net ([89.144.200.71] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mDTwI-00CIZe-7n; Tue, 10 Aug 2021 15:45:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "Richard Russon (FlatCap)" <ldm@flatcap.org>,
        linux-block@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: pass a gendisk instead of block_device in the partitioning code
Date:   Tue, 10 Aug 2021 17:45:08 +0200
Message-Id: <20210810154512.1809898-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi Jens,

this series passes the gendisk instead of the block_device when operating
on the whole device in the partition code.
