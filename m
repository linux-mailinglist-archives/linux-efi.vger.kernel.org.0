Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03D8BFB375
	for <lists+linux-efi@lfdr.de>; Wed, 13 Nov 2019 16:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbfKMPQ4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 13 Nov 2019 10:16:56 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:40770 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726335AbfKMPQz (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Wed, 13 Nov 2019 10:16:55 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5B71C441CED4AA3D3FBC;
        Wed, 13 Nov 2019 23:16:53 +0800 (CST)
Received: from lhrphicprd00229.huawei.com (10.123.41.22) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 13 Nov 2019 23:16:44 +0800
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-edac@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linux-efi@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>, <james.morse@arm.com>
CC:     <rjw@rjwysocki.net>, <tony.luck@intel.com>, <linuxarm@huawei.com>,
        <ard.biesheuvel@linaro.org>, <nariman.poushin@linaro.org>,
        Thanu Rangarajan <Thanu.Rangarajan@arm.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v4 0/6]  CCIX Protocol error reporting.
Date:   Wed, 13 Nov 2019 23:16:21 +0800
Message-ID: <20191113151627.7950-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.41.22]
X-CFilter-Loop: Reflected
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Changes since V3:

Added #if defined(CONFIG_ACPI_APEI_CCIX) build protection to the
tracepoints to avoid using undefined functions.
Reported-by: 0-day.

Changes since V2:

Dropped the legal boiler plate from the cover letter. The CCIX consortium
have agreed that a simple tradmark statement is sufficient which I have
put in the cper-ccix.c file and here.

The CCIX® trademark and CCIX trade name are owned solely by
CCIX CONSORTIUM, INC. and all rights are reserved therein.

Changes since V1:

Addressed comments from James Morse
- Dropped kernel logging of vendor data. We just push it to the tracepoints.
- Tidied up this cover letter and added information to address questions
  raised. Includes removing questions where James and I agreed ;)

Note, this initial series attempts no 'handling' of errors.
That will follow later.

EFI 2.8 defines a new CPER record Appendix N for CCIX Protocol Error Records
(PER). www.uefi.org

These include Protocol Error Record logs which are defined in the
CCIX 1.0 Base Specification www.ccixconsortium.com.  A public evaluation
version is now available.

Handling of coherency protocol errors is complex and how Linux does this
will take some time to evolve.  For now, fatal errors are handled via the
usual means and everything else is reported.

There are 6 types of error defined, covering:
* Memory errors
* Cache errors
* Address translation unit errors
* CCIX port errors
* CCIX link errors
* Agent internal errors.

These errors are concerned (mostly) wth things happening in the CCIX
protocol layer.  They are parallel to AER errors which should be only
concerned with the PCIe layer (which is underneath CCIX).
The ATS errors break this rule slightly. You may get an error
occurring that results in problems at both layers of the protocol
stack and hence have to handle AER and PER errors simultaneously.

Some of these errors can 'almost' be mapped onto standard existing error
types but only at the loss of information specific to CCIX such as
where in the topology they occurred.

The set includes tracepoints to report the errors to RAS Daemon and a patch
set for RAS Daemon will follow shortly.

Several design decisions that people may disagree with.
1. Reporting of vendor data.  We have little choice but to do this via a
   dynamic array as these blocks can take arbitrary size. I had hoped
   no one would actually use these given the odd mismatch between a
   standard error structure and non standard element, but there are
   already designs out there that do use it. James suggested that
   it made sense to put these in the tracepoints, but we shouldn't spam
   the kernel log with them (done in V2).
2. The trade off between explicit tracepoint fields, on which we might
   want to filter in kernel, and the simplicity of a blob.
   I have gone for having the whole of the block specific to the PER
   error type in an opaque blob.
   The key elements that may be filtered on are the physical address
   and the source and component fields which allow you to identify
   faulty devices. Note that you have to know how the devices were
   enumerated to be able to do so.
3. Defined 6 new tracepoints rather than cramming everything into one.
   * They are all defined by the CCIX specification as independent error
     classes.
   * Many of them can only be generated by particular types of agent.
   * The handling required will vary widely depending on types.
     In the kernel some map cleanly onto existing handling. Keeping the
     whole flow separate will aide this. They vary by a similar amount
     in scope to the RAS errors found on an existing system which have
     independent tracepoints.
   * Separating them out allows for filtering on the tracepoints by
     elements that are not shared between them.
   * Muxing the lot into one record type can lead to ugly code both in
     kernel and in userspace.

Rasdaemon patches posted.
https://patchwork.kernel.org/cover/11116735/

Jonathan Cameron (6):
  efi / ras: CCIX Memory error reporting
  efi / ras: CCIX Cache error reporting
  efi / ras: CCIX Address Translation Cache error reporting
  efi / ras: CCIX Port error reporting
  efi / ras: CCIX Link error reporting
  efi / ras: CCIX Agent internal error reporting

 drivers/acpi/apei/Kconfig        |   8 +
 drivers/acpi/apei/ghes.c         |  59 ++
 drivers/firmware/efi/Kconfig     |   5 +
 drivers/firmware/efi/Makefile    |   1 +
 drivers/firmware/efi/cper-ccix.c | 919 +++++++++++++++++++++++++++++++
 drivers/firmware/efi/cper.c      |   6 +
 include/linux/cper.h             | 333 +++++++++++
 include/ras/ras_event.h          | 407 ++++++++++++++
 8 files changed, 1738 insertions(+)
 create mode 100644 drivers/firmware/efi/cper-ccix.c

-- 
2.20.1

